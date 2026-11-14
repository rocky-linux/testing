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

full_path="$(realpath "$0")"
dir_path="$(dirname "$full_path")"
parent_path="$(dirname "$dir_path")"

source "${dir_path}/common_opts.sh"

iso_url="${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos/${iso_arch}/${iso_prefix}-${iso_version}-${iso_arch}-${iso_type}.iso"
iso_name=$(basename "${iso_url}")

iso_checksum_url="${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos/${iso_arch}/${iso_checksum_name}"
iso_checksum_sig_url="${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos/${iso_arch}/${iso_checksum_name}${iso_checksum_sig}"

mkdir -pv "${log_dir}" || exit
log_base="${log_dir}/${iso_name}"
log_file="${log_base}.mediacheck.out"

truncate -s0 "${log_file}" || exit

printf -v msg "%s"  "Derived URLs...\n\n" \
                    "iso_url:              ${iso_url}\n" \
                    "iso_checksum_url:     ${iso_checksum_url}\n" \
                    "iso_checksum_sig_url: ${iso_checksum_sig_url}\n" \
                    "iso_key_url:          ${iso_key_url}"
log_msg "${msg}" "${log_file}"

# Verify rpm pre-requisites are met
rpm --quiet -q curl || sudo dnf -y install curl || exit 1
rpm --quiet -q openssl || sudo dnf -y install openssl || exit 1
rpm --quiet -q gnupg2 || suo dnf -y install gnupg2 || exit 1
rpm --quiet -q isomd5sum || sudo dnf -y install isomd5sum || exit 1

curl_opts="-LRsvf"
curl_suffix="?v=$(openssl rand -hex 16)"

# Verify the iso_mirror_base and iso_url locations exist
log_msg "Verifying: ${iso_mirror_base} exists..." "${log_file}"
if ! curl --silent --fail -I "${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos" >/dev/null 2>&1
then
  log_msg "ERROR: ${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos does NOT exist." "${log_file}"
  exit 1
else
  echo "FOUND: ${iso_mirror_base}/${iso_content_dir}/${iso_version}/isos" | \
  tee -a "${log_file}"
fi

log_msg "Verifying: ${iso_url} exists..." "${log_file}"
if ! curl --silent --fail -I "${iso_url}" >/dev/null 2>&1
then
  log_msg "ERROR: ${iso_url} does NOT exist." "${log_file}"
  exit 1
else
  echo "FOUND: ${iso_url}" | tee -a "${log_file}"
fi

# Always re-pull the CHECKSUM and CHECKSUM signature because arches use common filename
log_msg "Downloading: ${iso_checksum_url} ..." "${log_file}"
curl "${curl_opts}" "${iso_checksum_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_checksum_url}")" 2>&1 | \
  tee -a "${log_file}"
test -f "${parent_path}/${iso_checksum_name}" || exit 1

log_msg "Verifying: ${iso_checksum_sig_url} exists..." "${log_file}"
set +e
if ! curl --silent --fail -I "${iso_checksum_sig_url}" >/dev/null 2>&1
then
  log_msg "WARNING: ${iso_checksum_sig_url} does NOT exist.\nWARNING: GPG signature validation of ${iso_checksum_name} will fail." "${log_file}"
  set -e
else
  echo "FOUND: ${iso_checksum_sig_url}" | tee -a "${log_file}"
  log_msg "Downloading: ${iso_checksum_sig_url} ..." "${log_file}"
  set -e
  curl "${curl_opts}" "${iso_checksum_sig_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_checksum_sig_url}")" 2>&1 | \
    tee -a "${log_file}"
  test -f "${parent_path}/${iso_checksum_name}${iso_checksum_sig}" || exit 1
fi

# Pull the signing key only if it doesn't exist in $PWD
test -f "${iso_key_name}" || \
  ( \
    log_msg "Downloading: ${iso_key_url} ..." "${log_file}"; \
    curl "${curl_opts}" "${iso_key_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_key_url}")" 2>&1 \
  ) | tee -a "${log_file}"
test -f "${parent_path}/${iso_key_name}" || exit 1

# Pull the ISO only if it doesn't exist in $PWD, it may have been copied from $PWD/isos by wrapper
test -f "${iso_name}" || \
  ( \
    log_msg "Downloading: ${iso_name} ..." "${log_file}"; \
    curl "${curl_opts}" "${iso_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_url}")" 2>&1 \
  ) | tee -a "${log_file}"
test -f "${iso_name}" || exit 1

# Verify the CHECKSUM file using gpg
log_msg "Importing: ${iso_key_name} ..." "${log_file}"
bash -x -c "gpg --import ${parent_path}/${iso_key_name}" 2>&1 | \
  tee -a "${log_file}"

log_msg "Verifying gpg signature: ${parent_path}/${iso_checksum_name}${iso_checksum_sig} ..." "${log_file}"
bash -x -c "gpg --verify ${parent_path}/${iso_checksum_name}${iso_checksum_sig} ${parent_path}/${iso_checksum_name}" 2>&1 | \
  tee -a "${log_file}"

# Verify the externally generated sha256sum of the ISO
log_msg "Verifying sha256sum: ${parent_path}/${iso_name} ..."  "${log_file}"
bash -x -c "sha256sum --ignore-missing -c ${parent_path}/${iso_checksum_name}"  2>&1 | \
  tee -a "${log_file}"

# Verify the internal md5sum that is inside the ISO
log_msg "Verifying internal ISO md5: ${parent_path}/${iso_name} ..." "${log_file}"
bash -x -c "checkisomd5 ${parent_path}/${iso_name}"  2>&1 | \
  tee -a "${log_file}"
