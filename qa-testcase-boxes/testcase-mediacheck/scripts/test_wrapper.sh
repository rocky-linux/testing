#!/bin/bash

. /etc/os-release

t="${1:-boot}"
a="${2:-$(arch)}"
v="${3:-${VERSION_ID}}"
b="${4:-http://dl.rockylinux.org/pub/rocky/8/isos}"
c="${5:-CHECKSUM}"

full_path="$(realpath "$0")"
script_path="$(dirname "$full_path")"
parent_path="$(dirname "$script_path")"

cd "${parent_path}" || exit

test -f "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" && \
  mv "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" "${parent_path}/"

"${parent_path}/scripts/iso_download_mediacheck.sh" \
  -t "${t}" -a "${a}" -b "${b}" -v "${v}" -c "${c}"

"${parent_path}/scripts/iso_repoclosure_conflicts.sh" \
  -t "${t}" -a "${a}" -v "${v}"

mkdir -p "${parent_path}/isos/" && \
  mv "${parent_path}/Rocky-${v}-${a}-${t}.iso" "${parent_path}/isos/"
