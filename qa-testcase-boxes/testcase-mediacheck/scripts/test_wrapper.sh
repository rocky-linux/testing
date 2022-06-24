#!/bin/bash

t="${1:-boot}"
a="${2:-x86_64}"
v="${3:-8.6}"
b="${4:-http://dl.rockylinux.org/pub/rocky/8/isos}"

full_path="$(realpath "$0")"
script_path="$(dirname "$full_path")"
parent_path="$(dirname "$script_path")"

cd "${parent_path}" || exit

test -f "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" && \
  mv "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" "${parent_path}/"

"${parent_path}/scripts/iso_download_mediacheck.sh" \
  -t "${t}" -a "${a}" -b "${b}" -v "${v}"

"${parent_path}/scripts/iso_repoclosure_conflicts.sh" \
  -t "${t}" -a "${a}" -v "${v}"

mkdir -p "${parent_path}/isos/" && \
  mv "${parent_path}/Rocky-${v}-${a}-${t}.iso" "${parent_path}/isos/"
