#!/usr/bin/env bash

# Copyright (c) 2022 Rocky Enterprise Software Foundation
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice (including the next
# paragraph) shall be included in all copies or substantial portions of the
# Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
# Author: Trevor Cooper <tcooper@rockylinux.org>
#

# NOTE: This script will currently only pull packages from koji, dl.r.o. or
#       or a local repository cache (eg. Peridot yumrepofs).
#       Something else will be needed for builds in Peridot but what that is
#       will be TBD until Peridot is deployed and available for query.

function usage {
  printf "Usage: %s " "$(basename "${BASH_SOURCE[1]}")"
  printf "[-h] [-x] [-t minimal|dvd|dvd1|repo|koji|cache] [-a x86_64|aarch64|ppc64le|s390x] [-v 8.6|9.0|maj.min] [others... see -h] [package(s)]\n"
  printf "Perform debranding analysis on PACKAGEs.\n"

  cat <<- "EOF"

  -h                        provide this help
  -x                        enable extended output
  -t                        specify source for packages
                              minimal and {dvd,dvd1} specify locally available ISO
                              media, repo and koji specify Internet package sources
                              and cache specifies local package cache. If/when
                              using repo or koji packages pulled from that location
                              will be store in the local package cache.
  -a                        specify architecture for packages
                              x86_64 and aarch64 are available pre 9 while
                              ppc64le and s390x will be added for Rocky Linux 9
  -v                        specify Rocky Linux version for ISOs
                              Typically 8.6 or 8 depending on the repository
  -p                        iso filename prefix
                              The standard prefix for Rocky Linux is 'Rocky' with
                              the full ISO name being derived as...
                              <prefix>-<version>-<arch>-<type>.iso. Thus,
                              with creative use of these variables packages on
                              other ISOs (eg. prefix='CentOS-Stream') can possible
                              be examined as well.
  -b                        repository baseurl
                              Allows definition of non-default repository baseurl
                              to support os of vault or staging repositories or
                              even closest mirrors
                              default='http://dl.rockylinux.org/pub/rocky/'
  -l                        output log directory
                              default location for logs is $(pwd)/output/$(date +%Y-%m-%d)
                              but a custom location for the base for logs can be
                              supplied.
  -n                        repository name(s)
                              default='baseos,appstream,extras,powertools' can
                              be overridden if/when working with a local repository
                              clone, for example of Peridot yumrepofs where this
                              might be... 'pdot-dev-x86_64'. Requires definition
                              of repo in /etc/yum.repos.d/<repofile>.repo
  -k                        koji tag
                              When koji is used for packages alternate koji tags
                              for package search may be used. default='dist-rocky8-compose'
  -r                        debrand yaml override
                              When debrand validation for a non-default version
                              is being performed a version specific YAML file
                              can be selected. default='8'

EOF
}

full_path="$(realpath "$0")"
dir_path="$(dirname "$full_path")"
parent_path="$(dirname "$dir_path")"

# Defaults
iso_type="dvd1"
iso_version="8.6"
iso_arch="$(arch)"
baseurl="http://dl.rockylinux.org/pub/rocky"
iso_baseurl="${baseurl}/${iso_version}/isos"
iso_prefix="Rocky"
log_dir="$(pwd)/output/$(date +%Y-%m-%d)"
repo_names="baseos,appstream,powertools,extras"
koji_tag="dist-rocky8-compose"
rocky_rel="8"
log_dir="${parent_path}/output/$(date +%Y-%m-%d)"
log_file_suffix="debrand_validation.out"
extended=0

optstring="hxt:a:v:p:n:s:b:r:k:c:"

while getopts ${optstring} arg; do
  case ${arg} in
    h)
      usage
      exit 0
      ;;
    t)
      iso_type="${OPTARG}"
      ;;
    a)
      iso_arch="${OPTARG}"
      ;;
    v)
      iso_version="${OPTARG}"
      ;;
    p)
      iso_prefix="${OPTARG}"
      ;;
    b)
      iso_baseurl="${OPTARG}"
      ;;
    l)
      log_dir="${OPTARG}"
      ;;
    n)
      repo_names="${OPTARG}"
      ;;
    k)
      koji_tag="${OPTARG}"
      ;;
    r)
      rocky_rel="${OPTARG}"
      ;;
    x)
      extended=1
      ;;
    :)
      echo "$0: Must supply an argument to -$OPTARG." >&2
      exit 1
      ;;
    ?)
      echo "Invalid option: -${OPTARG}."
      echo
      exit 1
      ;;
  esac
done

# The rest of the arguments are package names
shift "$((OPTIND -1))"
declare -a all_pkgs=()
for pkg in "$@"; do
  all_pkgs+=("${pkg}")
done

log_msg() {
    printf '%b\n' "$1" | tee -a "${log_file}"
}

log_hdr() {
  msg=$(printf '=%.0s' {1..80})
  log_msg "\n${msg}\n${1}"
}

log_extra() {
  if (( extended == 1 )); then
    log_msg "$1"
  fi
}

mkdir -pv "${log_dir}" || exit
iso_name="${iso_prefix}-${iso_version}-${iso_arch}-${iso_type}"
log_base="${log_dir}/${iso_name}"
log_file="${log_base}.${log_file_suffix}"

truncate -s0 "${log_file}"

declare -r patch_yml="https://git.rockylinux.org/rocky/metadata/-/raw/main/patch.yml"
# if packages were supplied on the command line then this overrides the contents of patch.yml
if (( ${#all_pkgs[@]} == 0 )); then
  # get patch.yml from git.r.o and extract debrand pkgs
  #curl -sLOR "${patch_yml}"
  readarray all_pkgs < <(/usr/local/bin/yq '.debrand.r'"${rocky_rel}"' + .debrand.all | sort() | .[]' patch.yml)
fi

yq '.debrand | [.r9, .all] | .[] | .[]' patch.yml | sort | column -c100 -x

