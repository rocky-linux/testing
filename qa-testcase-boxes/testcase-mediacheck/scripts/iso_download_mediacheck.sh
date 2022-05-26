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

#set -x
set -e

function usage {

  cat <<- "EOF"
    $(basename $0) [optional arguments]

    type:                -t  eg; 'boot', 'minimal', 'dvd1', 'repo', 'koji', 'cache'
    arch:                -a  eg: 'x86_64', 'aarch64', 'ppc64-le' or 's390x'
    iso_version:         -v  eg: '8.6' or '8'
    iso_prefix:          -p  eg: 'Rocky' or 'CentOS-Stream'
    iso_mirror_base:     -b  eg: 'http://dl.rockylinux.org/stg/rocky/8/isos'
    iso_checksum_name:   -c  eg: 'CHECKSUM' or 'SHA256SUM'
    iso_checksum_sig:    -s  eg: '.sig' or '.asc'
    log_dir:             -l  eg: $(pwd)/output/$(date +%Y-%m-%d)
    repo_name:           -r  eg: 'pdot-dev-x86_64'
    koji_tag:            -k  eg: 'dist-rocky8-compose'
EOF
}

full_path="$(realpath "$0")"
dir_path="$(dirname "$full_path")"
parent_path="$(dirname "$dir_path")"

# Defaults
iso_version="8.6"
iso_arch="$(arch)"
iso_type="boot"
iso_mirror_base="http://dl.rockylinux.org/pub/rocky/${iso_version}/isos"
iso_prefix="Rocky"
iso_checksum_name="CHECKSUM"
iso_checksum_sig=".sig"
iso_key_name="RPM-GPG-KEY-rockyofficial"
iso_key_url="https://dl.rockylinux.org/pub/rocky/RPM-GPG-KEY-rockyofficial"
log_dir="${parent_path}/output/$(date +%Y-%m-%d)"

optstring="ht:a:v:p:c:s:b:k:"

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
    c)
      iso_checksum_name="${OPTARG}"
      ;;
    s)
      iso_checksum_sig="${OPTARG}"
      ;;
    b)
      iso_mirror_base="${OPTARG}"
      ;;
    k)
      iso_key_name="${OPTARG}"
      ;;
    l)
      log_dir="${OPTARG}"
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

iso_url="${iso_mirror_base}/${iso_arch}/${iso_prefix}-${iso_version}-${iso_arch}-${iso_type}.iso"
iso_name=$(basename "${iso_url}")

iso_checksum_url="${iso_mirror_base}/${iso_arch}/${iso_checksum_name}"
iso_checksum_sig_url="${iso_mirror_base}/${iso_arch}/${iso_checksum_name}${iso_checksum_sig}"

mkdir -pv "${log_dir}" || exit
log_base="${log_dir}/${iso_name}"

truncate -s0 "${log_base}.mediacheck.out"

function log_msg() {
    printf '\n' | tee -a "${log_base}.mediacheck.out"
    printf '=%.0s' {1..80} | tee -a "${log_base}.mediacheck.out"
    printf '\n%b\n\n' "$1" | tee -a "${log_base}.mediacheck.out"
}

log_msg "Derived URLs..."
echo "iso_url:              ${iso_url}"
echo "iso_checksum_url:     ${iso_checksum_url}"
echo "iso_checksum_sig_url: ${iso_checksum_sig_url}"
echo "iso_key_url:          ${iso_key_url}"

curl_opts="-LRsvf"
curl_suffix="?v=$(openssl rand -hex 16)"

# First verify the iso_mirror_base and iso_url locations exist
log_msg "Verifying: ${iso_mirror_base} exists..."
if ! curl --silent --fail -I "${iso_mirror_base}" >/dev/null 2>&1
then
  log_msg "ERROR: ${iso_mirror_base} does NOT exist."
  exit
fi

log_msg "Verifying: ${iso_url} exists..."
if ! curl --silent --fail -I "${iso_url}" >/dev/null 2>&1
then
  log_msg "ERROR: ${iso_url} does NOT exist."
  exit
fi

# Always re-pull the CHECKSUM and CHECKSUM.sig because arches use common filename
log_msg "Downloading: ${iso_checksum_url} ..."
curl "${curl_opts}" "${iso_checksum_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_checksum_url}")" 2>&1 | \
  tee -a "${log_base}.mediacheck.out"
test -f "${parent_path}/${iso_checksum_name}" || exit

log_msg "Downloading: ${iso_checksum_sig_url} ..."
curl "${curl_opts}" "${iso_checksum_sig_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_checksum_sig_url}")" 2>&1 | \
  tee -a "${log_base}.mediacheck.out"
test -f "${parent_path}/${iso_checksum_name}${iso_checksum_sig}" || exit

# Pull the signing key and ISO only if they don't exist in $PWD
test -f "${iso_key_name}" || \
  ( \
    log_msg "Downloading: ${iso_key_url} ..."; \
    curl "${curl_opts}" "${iso_key_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_key_url}")" 2>&1 \
  ) | tee -a "${log_base}.mediacheck.out"
test -f "${parent_path}/${iso_key_name}" || exit

test -f "${iso_name}" || \
  ( \
    log_msg "Downloading: ${iso_name} ..."; \
    curl "${curl_opts}" "${iso_url}${curl_suffix}" -o "${parent_path}/$(basename "${iso_url}")" 2>&1 \
  ) | tee -a "${log_base}.mediacheck.out"
test -f "${iso_name}" || exit

# Verify the CHECKSUM file using gpg
log_msg "Importing: ${iso_key_name} ..."
gpg --import "${parent_path}/${iso_key_name}" 2>&1 | \
  tee -a "${log_base}.mediacheck.out"
log_msg "Verifying gpg signature: ${parent_path}/${iso_checksum_name}${iso_checksum_sig} ..." | \
  tee -a "${log_base}.mediacheck.out"
gpg --verify-files "${parent_path}/${iso_checksum_name}${iso_checksum_sig}"  2>&1 | \
  tee -a "${log_base}.mediacheck.out"

# Verify the externally generated sha256sum of the ISO
log_msg "Verifying sha256sum: ${parent_path}/${iso_name} ..." | \
  tee -a "${log_base}.mediacheck.out"
sha256sum --ignore-missing -c "${parent_path}/${iso_checksum_name}"  2>&1 | \
  tee -a "${log_base}.mediacheck.out"

# Verify the internal md5sum that is inside the ISO
log_msg "Verifying internal ISO md5: ${parent_path}/${iso_name} ..." | \
  tee -a "${log_base}.mediacheck.out"
checkisomd5 "${parent_path}/${iso_name}"  2>&1 | \
  tee -a "${log_base}.mediacheck.out"
