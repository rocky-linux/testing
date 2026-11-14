#!/bin/bash

. /etc/os-release

t="${1:-boot}"
a="${2:-$(arch)}"
# get VERSION_ID from /etc/os-release which is ${ver_major}.${ver_minor} for Rocky
v="${3:-${VERSION_ID}}"
b="${4:-http://dl.rockylinux.org}"
d="${5:-pub/rocky}"
c="${6:-CHECKSUM}"
k="${7:-RPM-GPG-KEY-Rocky-9}"

full_path="$(realpath "$0")"
script_path="$(dirname "$full_path")"
parent_path="$(dirname "$script_path")"

cd "${parent_path}" || exit

# Move existing ISO to testdir if found
test -f "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" && \
  mv "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" "${parent_path}/"

# Download ISO if needed and validate
"${parent_path}/scripts/iso_download_mediacheck.sh" \
  -t "${t}" -a "${a}" -v "${v}" -b "${b}" -d "${d}" -c "${c}" -k "${k}"

# Perform repoclosure and file conflicts validation on ISO
"${parent_path}/scripts/iso_repoclosure_conflicts.sh" \
  -t "${t}" -a "${a}" -v "${v}"

# Perform insights and rhsm validation on ISO
"${parent_path}/scripts/iso_repository_validation.sh" \
  -t "${t}" -a "${a}" -v "${v}"

# Move ISO to isos/ directory
mkdir -p "${parent_path}/isos/" && \
  mv "${parent_path}/Rocky-${v}-${a}-${t}.iso" "${parent_path}/isos/"
