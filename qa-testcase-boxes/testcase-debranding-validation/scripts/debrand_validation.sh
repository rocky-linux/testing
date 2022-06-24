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
  printf "[-h] [-x] [-t minimal|dvd1|repo|koji|cache] [-a x86_64|aarch64|ppc64le|s390x] [-v 8.6|9.0|maj.min] [others... see -h] [package(s)]\n"
  printf "Perform debranding analysis on PACKAGEs.\n"

  cat <<- "EOF"

  -h                        provide this help
  -x                        enable extended output
  -t                        specify source for packages
                              minimal and dvd1 specify locally available ISO
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
  curl -sLOR "${patch_yml}"
  readarray all_pkgs < <(/usr/local/bin/yq '.debrand.r'"${rocky_rel}"' + .debrand.all | sort() | .[]' patch.yml)
fi

# Configure downloads to be from koji, repository, ISO or use package cache
if [[ "${iso_type}" == *"koji"* ]]; then
  log_hdr "Package Debrand Validation for ${iso_arch} builds in ${iso_type}"
elif [[ "${iso_type}" == *"repo"* ]]; then
  log_hdr "Package Debrand Validation for ${iso_arch} packages in ${repo_names} repos"
  msg=$(dnf --refresh --disablerepo=* --enablerepo="${repo_names}" repoinfo 2>&1)
  [ -n "$msg" ] && log_extra "\n${msg}\n"
elif [[ "${iso_type}" == *"cache"* ]]; then
  log_hdr "Package Debrand Validation for ${iso_arch} packages in local package ${iso_type}"
else
  log_hdr "Package Debrand Validation for ${iso_arch} packages in ${iso_name}.iso"

  iso_url="${iso_baseurl}/${iso_version}/isos/${iso_arch}/${iso_prefix}-${iso_version}-${iso_arch}-${iso_type}.iso"
  iso_name=$(basename "${iso_url}")

  if [[ "${iso_type}" == *"minimal"* ]]
  then
    log_msg "WARN: ${iso_name} may not contain all packages requiring debranding.\n"
  fi

  if [[ "${iso_type}" == *"boot"* ]]
  then
    log_msg "\nERROR: ${iso_name} does not contain local repositories.\n"
    exit 1
  fi

  # For minimal and dvd ISOs there is/are repos inside the media
  sudo mount -o loop,ro "${iso_name}" /media || exit
  mapfile -t repodata_dirs < <(find /media -name repodata)

  if [[ "${repodata_dirs[*]}" =~ "repodata" ]]; then
    # Construct dnf download command with repodata from ISO
    dnf_cmd="dnf download --urls"
    for rd in "${repodata_dirs[@]}"
    do
      dn=$(dirname "${rd}")
      rn=$(basename "${dn}")
      dnf_cmd="${dnf_cmd} --repofrompath ${rn},${dn} --repo ${rn}"
    done
  fi
fi

# We always want to know the list of packages being evaluated
msg=$(printf "\n%s\n" "${all_pkgs[@]}" | column -x)
[ -n "$msg" ] && log_extra "\n${msg}\n"

# Cache RPMs to improve performance on reruns when pulling from koji or repository
script_dir="$(dirname "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")")"
rpm_cache_dir="$(dirname "${script_dir}")/rpms"

log_hdr   "General Processing Parameters\n"
log_msg   "             type: ${iso_type}"
log_msg   "          version: ${iso_version}"
log_msg   "             arch: ${iso_arch}"
log_extra "          baseurl: ${baseurl}"
log_extra "      iso_baseurl: ${iso_baseurl}"
log_extra "       iso_prefix: ${iso_prefix}"
log_extra "       repo_names: ${repo_names}"
log_extra "         koji_tag: ${koji_tag}"
log_extra "        rocky_rel: ${rocky_rel}"
log_extra "          log_dir: ${log_dir}"
log_extra "  log_file_suffix: ${log_file_suffix}"
log_extra "         extended: ${extended}"
log_extra "       script_dir: ${script_dir}"
log_extra "    rpm_cache_dir: ${rpm_cache_dir}"

download_from_iso(){
  pkg_path=$(find /media -name "${2}" -type f)
  log_extra "         pkg_path: ${pkg_path}\n"
  dn="$(dirname "${pkg_path}")"
  msg=$(cp -fv "${pkg_path}" "${rpm_cache_dir}")
  [ -n "$msg" ] && log_extra "\n${msg}\n"
}

koji_pkg_name(){
  # Don't know how to find modular packages in koji yet. Maybe Peridot will solve?
  # Requires complete nvra.
  koji_pkg="${2}"
  if [[ "${yml_modular}" != "true" ]]; then
    koji_pkg="$(koji latest-build --arch="${yml_pkg_arch}" "${koji_tag}" "${1}" | \
      grep -E "^${yml_nvr_pkg}.${yml_pkg_arch}" | grep -Ev "debugsource|debuginfo")"
      # NOTE: At this point if the debrand.yaml file is not current with the
      #       latest koji build you will not have a package.
      #       Optionally, search for ${yml_nv_pkg} in ${yml_nvr_pkg} to see if
      #       RELEASE has been updated - TODO
  fi
  echo "${koji_pkg}.rpm"
}

download_from_koji(){
  koji_pkg="$(koji_pkg_name "${1}" "${2}")"
  log_extra "         koji_pkg: ${koji_pkg}\n"
  pushd "${rpm_cache_dir}" >/dev/null || return
  #msg=""
  #stat "${koji_pkg}" >/dev/null 2>&1 || msg=$(koji download-build --rpm "${koji_pkg}" 2>&1)
  msg=$(koji download-build --rpm "${koji_pkg}" 2>&1)
  [ -n "$msg" ] && log_extra "${msg}\n"
  popd >/dev/null || return
}

download_from_repo(){
  pushd "${rpm_cache_dir}" >/dev/null || return
  if (( extended == 1 )); then
    msg=$(dnf --disablerepo=* --enablerepo="${repo_names}" download --urls "${2}" 2>/dev/null | grep -Ev "^Last metadata")
    log_extra "        repo_path: ${msg}\n"
  fi
  msg=$(dnf --disablerepo=* --enablerepo="${repo_names}" download "${2}" 2>&1)
  [ -n "$msg" ] && log_extra "\n${msg}\n"
  popd >/dev/null || return
}

extract_pkg(){
  log_extra "       cache_path: ${rpm_cache_dir}/${1}"
  msg=$(rpm2cpio "${rpm_cache_dir}/${1}" 2>&1 | cpio -idm 2>&1)
  [ -n "$msg" ] && log_extra "\n${msg}\n"
}

download_and_extract(){
  tmpdir=$(mktemp -d)
  pushd "${tmpdir}" >/dev/null || return

  case "${iso_type}" in
    (dvd1|minimal)
      download_from_iso "${1}" "${2}"
      extract_pkg "${2}"
      ;;
    (koji)
      download_from_koji "${1}" "${2}"
      extract_pkg "${2}"
      ;;
    (repo)
      download_from_repo "$(basename -s ".rpm" "${2}")"
      extract_pkg "${2}"
      ;;
    (cache)
      extract_pkg "${2}"
      ;;
    (*)
      ;;
  esac

  popd >/dev/null || return
}

download_only(){
  # download directly to package cache
  case "${iso_type}" in
    (dvd1|minimal)
      download_from_iso "${1}" "${2}"
      ;;
    (koji)
      download_from_koji "${1}" "${2}"
      ;;
    (repo)
      download_from_repo "${1}" "${2}"
      ;;
    (*)
      ;;
  esac
}

# Iterate over all_pkgs[@] and process
for pkg in "${all_pkgs[@]}"
do

  log_hdr "$pkg"
  rep_pkg=${pkg//[\.]/_}

  query=".*.${rep_pkg}"
  readarray -t criteria < <(/usr/local/bin/yq "${query} | .[]" "r${rocky_rel}.yaml" | grep -Ev "^null$")

  yml_modular="${criteria[0]}"
  yml_check="${criteria[1]}"
  yml_nvr_pkg="${criteria[2]}"
  yml_file="${criteria[3]:-na}"
  yml_content="${criteria[4]:-na}"
  yml_value="${criteria[5]:-true}"
  yml_pkg_arch="${criteria[6]:-${iso_arch}}"
  yml_source="${criteria[7]:-na}"

  log_extra "\nr${rocky_rel}.yaml contents for ${pkg}\n"
  log_extra "          modular: $yml_modular"
  log_extra "            check: $yml_check"
  log_extra "          nvr_pkg: $yml_nvr_pkg"
  log_extra "             file: $yml_file"
  log_extra "          content: $yml_content"
  log_extra "            value: $yml_value"
  log_extra "         pkg_arch: $yml_pkg_arch"
  log_extra "           source: $yml_source"

  case "${iso_type}" in
    (dvd1|minimal)
      if [[ "${yml_pkg_arch}" == "src" ]]; then
        src_pkg="${yml_nvr_pkg}.${yml_pkg_arch}.rpm"
        log_extra "src_pkg: ${src_pkg}\n"
        log_msg "WARN: ${iso_type} media does not contain SRPMs, use koji or cache"
        continue
      fi
      ;;
    (*)
      ;;
  esac

  binary_pkg="${yml_nvr_pkg}.${yml_pkg_arch}.rpm"
  case "${yml_pkg_arch}" in
    (src)
      log_msg "          src_pkg: ${binary_pkg}"
      ;;
    (x86_64|noarch|aarch64|ppc64le|s390x)
      log_msg "\n       binary_pkg: ${binary_pkg}"
      ;;
    (*)
      ;;
  esac

  tmpdir=""
  case "${yml_check}" in

    PackageRequires)
      # This is a package metadata check and doesn't require extract of the package
      # just download directly to local cache
      pushd "${rpm_cache_dir}" >/dev/null || return
      download_only "${pkg}" "${binary_pkg}"
      if [[ "${yml_value}" == "true" ]]; then
        if ( ( rpm -q --requires -p "${binary_pkg}" | grep -Eq "${yml_content}" ) ); then
          log_msg "\nSUCCESS: PackageRequires: ${binary_pkg}.rpm requires ${yml_content}"
        else
          log_msg "FAIL: PackageRequires: ${binary_pkg}.rpm does not require ${yml_content}."
        fi
      else
        if ( ( rpm -q --requires -p "${binary_pkg}" | grep -Eq "${yml_content}" ) ); then
          log_msg "FAIL: PackageRequires: ${binary_pkg}.rpm requires ${yml_content}"
        else
          log_msg "\nSUCCESS: PackageRequires: ${binary_pkg}.rpm does not require ${yml_content}."
        fi
      fi
      popd >/dev/null || return
      ;;

    BinaryStrings)
      download_and_extract "${pkg}" "${binary_pkg}"
      if [[ -f "${tmpdir}/${yml_file}" ]]; then
        if [[ "${yml_value}" == "true" ]]; then
          if ( ( strings "${tmpdir}/${yml_file}" | grep -Eq "${yml_content}" ) ); then
            log_msg "\nSUCCESS: ${yml_check} found pattern."
          else
            log_msg "FAIL: ${yml_file} does not contain pattern."
          fi
        else
          if ( ( strings "${tmpdir}/${yml_file}" | grep -Eq "${yml_content}" ) ); then
            log_msg "FAIL: ${yml_check} found pattern."
          else
            log_msg "\nSUCCESS: ${yml_file} does not contain pattern."
          fi
        fi
      else
        log_msg "WARN: ${tmpdir}${yml_file} does not exist, should you be using koji or cache?"
      fi
      /bin/rm -rf "${tmpdir}"
      ;;

    FileContents)
      download_and_extract "${pkg}" "${binary_pkg}"
      if [[ -f "${tmpdir}/${yml_file}" ]]; then
        case "${yml_file}" in
          *.gz)
            gunzip "${tmpdir}/${yml_file}"
            yml_file="$(dirname "${yml_file}")/$(basename -s .gz "${yml_file}")"
            ;;
        esac
        if [[ "${yml_value}" == "true" ]]; then
          if ( ( grep -Eq "${yml_content}" "${tmpdir}/${yml_file}" ) ); then
            log_msg "\nSUCCESS: ${yml_check} found pattern."
          else
            log_msg "FAIL: ${yml_file} does not contain pattern."
          fi
        else
          if ( ( grep -Eq "${yml_content}" "${tmpdir}/${yml_file}" ) ); then
            log_msg "FAIL: ${yml_check} found pattern."
          else
            log_msg "\nSUCCESS: ${yml_file} does not contain pattern."
          fi
        fi
      else
        log_msg "WARN: ${tmpdir}/${yml_file} does not exist, should you be using koji or cache?"
      fi
      /bin/rm -rf "${tmpdir}"
      ;;

    FileChecksum)
      download_and_extract "${pkg}" "${binary_pkg}"
      if [[ -f "${tmpdir}/${yml_file}" ]]; then
        if [[ "${yml_value}" == "true" ]]; then
          if ( ( sha256sum "${tmpdir}/${yml_file}" | grep -Eq "${yml_content}" ) ); then
            log_msg "\nSUCCESS: ${yml_check} found pattern."
          else
            log_msg "FAIL: ${yml_file} does not contain pattern."
          fi
        else
          if ( ( sha256sum "${tmpdir}/${yml_file}" | grep -Eq "${yml_content}" ) ); then
            log_msg "FAIL: ${yml_check} found pattern."
          else
            log_msg "\nSUCCESS: ${yml_file} does not contain pattern."
          fi
        fi
      else
        log_msg "WARN: ${tmpdir}${yml_file} does not exist, should you be using koji or cache?"
      fi
      /bin/rm -rf "${tmpdir}"
      ;;

    FileExists)
      download_and_extract "${pkg}" "${binary_pkg}"
      if [[ -f "${tmpdir}/${yml_file}" ]]; then
        if [[ "${yml_value}" == "true" ]]; then
          if ( ( stat "${tmpdir}/${yml_file}" >/dev/null 2>&1 ) ); then
            log_msg "\nSUCCESS: ${yml_check}."
          else
            log_msg "FAIL: ${yml_file} does not exist."
          fi
        else
          if ( ( stat "${tmpdir}/${yml_file}" >/dev/null 2>&1 ) ); then
            log_msg "FAIL: ${yml_check}."
          else
            log_msg "\nSUCCESS: ${yml_file} does not exist."
          fi
        fi
      else
        log_msg "WARN: ${tmpdir}${yml_file} does not exist, should you be using koji or cache?"
      fi
      /bin/rm -rf "${tmpdir}"
      ;;

    *)
      ;;
  esac

done

case "${iso_type}" in
  (dvd1|minimal)
    sudo umount /media
    ;;
  (*)
    ;;
esac
