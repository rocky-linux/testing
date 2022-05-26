#!/bin/bash

set -e

t="${1:-dvd1}"
a="${2:-x86_64}"
v="${3:-8.6}"

full_path="$(realpath "$0")"
script_path="$(dirname "$full_path")"
parent_path="$(dirname "$script_path")"

cd "${parent_path}" || exit

test -f "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" && \
  mv "${parent_path}/isos/Rocky-${v}-${a}-${t}.iso" "${parent_path}/"

"${parent_path}/scripts/debrand_validation.sh" \
  -t"${t}" -a"${a}" -v"${v}"

mkdir -p "${parent_path}/isos/" && \
  mv "${parent_path}/Rocky-${v}-${a}-${t}.iso" "${parent_path}/isos/"
