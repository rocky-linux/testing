#! /usr/bin/python3
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Library General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
# copyright (c) 2008 Red Hat, Inc
#
# Authors: Seth Vidal and Jesse Keating

# This script used for the following test case:
# https://fedoraproject.org/wiki/QA:Testcase_Mediakit_FileConflicts

# Modifications: Trevor Cooper <tcooper@rockylinux.org>


"""Go through a dnf packagesack and return the list of newest pkgs which
   possibly have conflicting files"""

from collections import defaultdict
from optparse import OptionParser
from urllib.request import urlopen

import datetime
import time
import sys
import os
import os.path
import tempfile
import shutil
import re

import dnf
import rpm
import hawkey

# iterate all pkgs, build a filedict of filename = [list of pkg objects]
# then go through that list, if any file has more than one pkg then put those
# pkgs in another list
# print out the file conflict and the pkgs which potentially conflict
# later: work on whittling down the list by removing:
#        pkgs which are multilib sets
#        pkgs which have fully matching overlapping files (md5sums + timestamps)

def pkg_names_match(pkglist):
    "not a great check but it does toss out all the glibc.i686 vs glibc.i386 ones"
    p = pkglist[0]
    for pkg in pkglist[1:]:
        if p.name != pkg.name:
            return False

    return True

def sourcerpms_match(pkglist):
    "if they have the same sourcerpm it is highly doubtful it is a legit conflict"
    p = pkglist[0]
    for pkg in pkglist[1:]:
        if p.sourcerpm != pkg.sourcerpm:
            return False

    return True

# And this is just ugly piece of yum we are going to copy n paste
def compareEVR(left_tuple, right_tuple):
    """
    return 1: a is newer than b
    0: a and b are the same version
    -1: b is newer than a
    """
    (e1, v1, r1) = left_tuple
    (e2, v2, r2) = right_tuple
    if e1 is None:
        e1 = '0'
    else:
        e1 = str(e1)
    v1 = str(v1)
    r1 = str(r1)
    if e2 is None:
        e2 = '0'
    else:
        e2 = str(e2)
    v2 = str(v2)
    r2 = str(r2)
    #print '%s, %s, %s vs %s, %s, %s' % (e1, v1, r1, e2, v2, r2)
    rc = rpm.labelCompare((e1, v1, r1), (e2, v2, r2))
    #print '%s, %s, %s vs %s, %s, %s = %s' % (e1, v1, r1, e2, v2, r2, rc)
    return rc

def rangeCompare(reqtuple, provtuple):
    """returns true if provtuple satisfies reqtuple"""
    (reqn, reqf, (reqe, reqv, reqr)) = reqtuple
    (n, f, (e, v, r)) = provtuple
    if reqn != n:
        return 0

    # unversioned satisfies everything
    if not f or not reqf:
        return 1

    # and you thought we were done having fun
    # if the requested release is left out then we have
    # to remove release from the package prco to make sure the match
    # is a success - ie: if the request is EQ foo 1:3.0.0 and we have
    # foo 1:3.0.0-15 then we have to drop the 15 so we can match
    if reqr is None:
        r = None
    if reqe is None:
        e = None
    if reqv is None: # just for the record if ver is None then we're going to segfault
        v = None

    # if we just require foo-version, then foo-version-* will match
    if r is None:
        reqr = None

    rc = compareEVR((e, v, r), (reqe, reqv, reqr))

    # does not match unless
    if rc >= 1:
        if reqf in ['GT', 'GE', 4, 12, '>', '>=']:
            return 1
        if reqf in ['EQ', 8, '=']:
            if f in ['LE', 10, 'LT', 2, '<=', '<']:
                return 1
        if reqf in ['LE', 'LT', 'EQ', 10, 2, 8, '<=', '<', '=']:
            if f in ['LE', 'LT', 10, 2, '<=', '<']:
                return 1

    if rc == 0:
        if reqf in ['GT', 4, '>']:
            if f in ['GT', 'GE', 4, 12, '>', '>=']:
                return 1
        if reqf in ['GE', 12, '>=']:
            if f in ['GT', 'GE', 'EQ', 'LE', 4, 12, 8, 10, '>', '>=', '=', '<=']:
                return 1
        if reqf in ['EQ', 8, '=']:
            if f in ['EQ', 'GE', 'LE', 8, 12, 10, '=', '>=', '<=']:
                return 1
        if reqf in ['LE', 10, '<=']:
            if f in ['EQ', 'LE', 'LT', 'GE', 8, 10, 2, 12, '=', '<=', '<', '>=']:
                return 1
        if reqf in ['LT', 2, '<']:
            if f in ['LE', 'LT', 10, 2, '<=', '<']:
                return 1
    if rc <= -1:
        if reqf in ['GT', 'GE', 'EQ', 4, 12, 8, '>', '>=', '=']:
            if f in ['GT', 'GE', 4, 12, '>', '>=']:
                return 1
        if reqf in ['LE', 'LT', 10, 2, '<=', '<']:
            return 1
#                if rc >= 1:
#                    if reqf in ['GT', 'GE', 4, 12, '>', '>=']:
#                        return 1
#                if rc == 0:
#                    if reqf in ['GE', 'LE', 'EQ', 8, 10, 12, '>=', '<=', '=']:
#                        return 1
#                if rc <= -1:
#                    if reqf in ['LT', 'LE', 2, 10, '<', '<=']:
#                        return 1

    return 0

# yum code ends here

def prco_to_tuple(prco_string):
    """
    Creates dependency tuple containing name and evr from single string provided by dnf
    Example input: "glib2(x86-64) >= 2.54.0"
    Example output: (glib2, "GE", (0, 2.54.0, 1))

    Architecture requirements are lost during the conversion. Release is set to 1 if missing.
    """
    sign = ""
    if "<=" in prco_string:
        sign = "LE"
        data = prco_string.split("<=")
    elif "<" in prco_string:
        sign = "LT"
        data = prco_string.split("<")
    elif ">=" in prco_string:
        sign = "GE"
        data = prco_string.split(">=")
    elif ">" in prco_string:
        sign = "GT"
        data = prco_string.split(">")
    elif "=" in prco_string:
        sign = "EQ"
        data = prco_string.split("=")
    else:
        sign = None
        data = [prco_string, None]

    # We might have got prco without evr
    if not data[1]:
        return (data[0], sign, (None, None, None))

    # Trim whitespace from start and end
    data[0] = data[0].strip()
    data[1] = data[1].strip()

    base_string_for_nevra = str(data[0] + "-" + data[1])
    # Hawkey nevra parser doesn't like brackets :/
    # Removes brackets and content inside them
    # eg. "glib2(x86-64) >= 2.54.0" > "glib2 >= 2.54.0"
    base_string_for_nevra = re.sub(r' *\(.*?\)', '', base_string_for_nevra)

    try:
        string_for_nevra = str(base_string_for_nevra + ".noarch")
        nevra = hawkey.split_nevra(string_for_nevra)
    # We might be missing release
    except hawkey.ValueException:
        string_for_nevra = str(base_string_for_nevra + "-1.noarch")
        nevra = hawkey.split_nevra(string_for_nevra)

    return (data[0], sign, (nevra.epoch, nevra.version, nevra.release))

def inPrcoRange(prcotype, p1, p2):
    "Checks if p1 satisfies p2 or vice versa"
    if prcotype:
        p1_data = getattr(p1, prcotype)
    else:
        raise Exception("Unexpected prcotype: %s" % prcotype)

    #p2 stays the same, no need to assign it again and again below
    p2_tuple = (p2.name, 'EQ', (p2.epoch, p2.version, p2.release))

    for item in p1_data:
        p1_tuple = prco_to_tuple(str(item))
        if rangeCompare(p1_tuple, p2_tuple):
            return True

    return False

def check_list_for_prco(prcotype, pkglist):
    """
    Compare each pair of packages in the pkglist to see if any of them
    obsoletes/conflicts/requires/provides the other
    """
    for p1 in pkglist:
        for p2 in pkglist:
            if p1 == p2:
                continue
            if inPrcoRange(prcotype, p1, p2) or inPrcoRange(prcotype, p2, p1):
                #print("%s and %s in prco range." % (p1.name, p2.name))
                return True

    return False


def obsolete_each_other(pkglist):
    "Checks if packages in pkglist obsolete each other"
    return check_list_for_prco('obsoletes', pkglist)


def package_conflict(pkglist):
    "Checks if packages in pkglist conflict"
    return check_list_for_prco('conflicts', pkglist)


def file_conflict_is_permitted(left_loc, right_loc, filename):
    """
    Returns True if rpm would allow both the given packages to share
    ownership of the given filename.
    """
    ts = rpm.TransactionSet()
    ts.setVSFlags(rpm._RPMVSF_NOSIGNATURES)

    fd_left = os.open(left_loc, os.O_RDONLY)
    fd_right = os.open(right_loc, os.O_RDONLY)

    left_files = rpm.files(ts.hdrFromFdno(fd_left))
    right_files = rpm.files(ts.hdrFromFdno(fd_right))

    # Close FDs
    os.close(fd_left)
    os.close(fd_right)

    if left_files[filename].matches(right_files[filename]):
        #print('Conflict on %s between %s and %s permitted because files match' % (filename, left_loc, right_loc))
        return True
    # TODO: Check if the following code is working properly and uncomment it eventually
    #if left_files[filename].color != right_files[filename].color:
    #    #print('Conflict on %s between %s and %s permitted because colors differ' % (filename, left_loc, right_loc))
    #    return True
    return False

def get_package(pkg):
    "Returns location of the package and downloads it if it's not available in local storage"
    if not "file://" in pkg.remote_location():
        pkg.base.download_packages([pkg])
    return pkg.localPkg()

def file_conflict(fn, pkglist):
    "Checks if is fn going to cause conflicts between packages from pkglist"
    for pkg_left in pkglist:
        location_left = get_package(pkg_left)
        for pkg_right in pkglist:
            if pkg_left == pkg_right:
                continue
            location_right = get_package(pkg_right)
            if not file_conflict_is_permitted(location_right, location_left, fn):
                return True
            return False

if __name__ == "__main__":

    usage = """
    Check given repos for possible file/package conflicts

    %s [-c <config file>] [-r <repoid>] [-r <repoid2>]
    """ % sys.argv[0]
    parser = OptionParser(usage=usage)
    parser.add_option("-c", "--config", default='/etc/yum.conf',
                      help='config file to use (defaults to /etc/yum.conf)')
    parser.add_option("-r", "--repoid", default=[], action='append',
                      help=("specify repo ids to query, can be specified multiple times "
                            "(default is all enabled)"))
    parser.add_option("-t", "--tempcache", default=False, action="store_true",
                      help="Use a temp dir for storing/accessing yum-cache")
    parser.add_option("--repofrompath", action="append",
                      help=("specify repoid & paths of additional repositories "
                            "- unique repoid and complete path required, can be specified multiple "
                            "times. Example. --repofrompath=myrepo,/path/to/repo"))
    (opts, _) = parser.parse_args()

    my = dnf.Base()
    my.read_all_repos()

    temp_cachedir = None
    if os.geteuid() != 0 or opts.tempcache:
        temp_cachedir = tempfile.mkdtemp(prefix='conflicts')
        my.conf.cachedir = temp_cachedir
    else:
        my.conf.cachedir = dnf.yum.misc.getCacheDir()

    if opts.repofrompath:
    # setup the fake repos
        for repo in opts.repofrompath:
            repoid, repopath = tuple(repo.split(','))
            if repopath[0] == '/':
                baseurl = 'file://' + repopath
            else:
                # This URL may be a redirect, like download.fedoraproject.org. We
                # need to resolve this redirect now, otherwise the redirect URL will
                # be used for every package header download and that a) will extremely
                # slow down download speed b) may cause consistency problems if not
                # always the same repo mirror is returned from the redirect
                with urlopen(repopath) as net_obj:
                    baseurl = repopath = net_obj.geturl()

            repopath = os.path.normpath(repopath)
            newrepo = dnf.repo.Repo(repoid)
            newrepo.name = repoid
            newrepo.baseurl = baseurl
            newrepo.basecachedir = my.conf.cachedir
            newrepo.metadata_expire = 0
            newrepo.timestamp_check = False
            my.repos.add(newrepo)
            print("Added %s repo from %s" % (repoid, repopath))

    if opts.repoid:
        for repo in my.repos.values():
            if repo.id not in opts.repoid:
                repo.disable()
            else:
                repo.enable()

    fulldict = defaultdict(list)

    print('Getting complete filelist for:')
    for repo in my.repos.iter_enabled():
        if repo.metalink:
            print(repo.metalink)
        else:
            print(repo.baseurl[0])

    my.fill_sack()
    q = my.sack.query()

    for package in q:
        if str(package.reponame) == "@System":
            continue
        #print('{} in repo {}'.format(package, package.reponame))
        for file_name in package.files:
            fulldict[file_name].append(package)

    print('%u files found.\n' % len(fulldict))

    print('Looking for duplicated filenames:')
    filedict = {}
    for file_name in fulldict.keys():
        if len(fulldict[file_name]) >= 2:
            filedict[file_name] = fulldict[file_name]
    del fulldict # frees up a little memory
    print('%u duplicates found.\n' % len(filedict))

    print('Doing more advanced checks to see if these are real conflicts:')
    count = 0
    found = 0
    total = len(filedict)
    milestone = int(0.05 * total)
    start = time.time()
    last = start
    package_conflicts = set()
    file_conflicts = {}
    for (file_name, package_list) in filedict.items():
        # /usr/lib/.build-id seems to be causing whole lot of false positives, so just skip it
        if '/usr/lib/.build-id' in file_name:
            count += 1
            continue
        if (pkg_names_match(package_list) or
                sourcerpms_match(package_list) or
                obsolete_each_other(package_list)):
            pass
        elif package_conflict(package_list):
            strlist = sorted([str(p) for p in package_list])
            package_conflicts.add('\n'.join(strlist))
            #print('%s|%s' % ('|'.join(strlist), file_name))
        elif file_conflict(file_name, package_list):
            # note the flow here: we only check for file conflicts if
            # we have not found a package conflict
            found += 1
            file_conflicts[file_name] = package_list

        # Timing / counting output
        count += 1
        if count % milestone == 0:
            now = time.time()
            percent = round(float(count*100) / total)
            files_per_sec = float(milestone) / (now - last)
            total_files_per_sec = float(count) / (now - start)
            eta_sec = float(total - count) / total_files_per_sec
            eta = str(datetime.timedelta(seconds=int(eta_sec)))
            print("%3u%% complete (%6u/%6u, %5u/sec), %4u found - eta %s" % \
                (percent, count, total, files_per_sec, found, eta))
            last = now
    del filedict
    print("\n%u file conflicts found." % len(file_conflicts))
    print("%u package conflicts found." % len(package_conflicts))

    # Reduce the file conflict results to a dict like
    # {"pkga,pkgb": [conflicting files], ...}
    fcbpp = defaultdict(list) # File Conflicts By Package-Pair
    for (file_name, package_list) in file_conflicts.items():
        pkgpair = '\n'.join(sorted([str(p) for p in package_list]))
        fcbpp[pkgpair].append(file_name)
    del file_conflicts

    print('\n== Package conflicts ==')
    for package_list in package_conflicts:
        print(package_list + "\n")

    print('\n== File conflicts, listed by conflicting packages ==')
    for (pkgpair, files) in fcbpp.items():
        print(pkgpair)
        for file_name in sorted(files):
            print('  ' + file_name)
        print("")

    # delete cache
    if temp_cachedir:
        shutil.rmtree(temp_cachedir)

    if fcbpp:
        # file conflicts should be considered a failure, thus exit 1
        sys.exit(1)
