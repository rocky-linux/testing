#!/bin/bash

set -e

full_path="$(realpath "$0")"
dir_path="$(dirname "$full_path")"
parent_path="$(dirname "$dir_path")"

set -x
for a in x86_64 aarch64; do
  for t in boot minimal dvd1; do
    "${parent_path}/scripts/test_wrapper.sh" "${t}" "${a}"
  done
done
