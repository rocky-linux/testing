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

iso_url="${iso_mirror_base}/${iso_version}/isos/${iso_arch}/${iso_prefix}-${iso_version}-${iso_arch}-${iso_type}.iso"
iso_name=$(basename "${iso_url}")

mkdir -pv "${log_dir}"
log_base="${log_dir}/${iso_name}"

if [[ "${iso_type}" == *"boot"* ]]
then
  # Do something to verify contents of boot ISOs?
  true
else
  # For minimal and dvd ISOs there is/are repos inside the media
  sudo mount -o loop,ro "${iso_name}" /media

  #repodata_dirs=($(find /media -name repodata))
  mapfile -t repodata_dirs < <(find /media -name repodata)

  find /media -name "*comps*.xml" -exec grep -H "insights-client" '{}' \;

  if [[ "${repodata_dirs[*]}" =~ "repodata" ]]
  then
    in_cmd="dnf --refresh groupinfo base "
    pl_cmd="dnf --refresh repoquery --whatrequires subscription-manager "
    rhsm_cmd="dnf download "

    for rd in "${repodata_dirs[@]}"
    do
      dn=$(dirname "${rd}")
      rn=$(basename "${dn}")
      in_cmd="${in_cmd} --repofrompath ${rn},${dn} --repo ${rn}"
      pl_cmd="${pl_cmd} --repofrompath ${rn},${dn} --repo ${rn}"
      rhsm_cmd="${rhsm_cmd} --repofrompath ${rn},${dn} --repoid ${rn}"
    done

    # insights-client should not be installed by default
    truncate -s0 "${log_base}.insights.out"
    log_msg "Running:\n\t${in_cmd} ..." "${log_base}.insights.out"
    bash -x -c "${in_cmd}" | tee -a "${log_base}.insights.out"

    # Packages requiring redhat-subscription-manager should not include refs to
    # other Redhat packages
    truncate -s0 "${log_base}.rhsm.out"
    log_msg "Running:\n\t${pl_cmd} ..." "${log_base}.rhsm.out"

    mapfile -t package_list < <(bash -c "${pl_cmd}" | tee -a "${log_base}.rhsm.out")

    if [[ ${#package_list[@]} -gt 0 ]]
    then
      rhsm_cmd="${rhsm_cmd} ${package_list[*]}"

      log_msg "Running:\n\t${rhsm_cmd} ..." "${log_base}.rhsm.out"
      bash -x -c "${rhsm_cmd}" | tee "${log_base}.rhsm.out"

      while IFS= read -r -d '' pkg
      do
        log_msg "Analyzing:\n\t${pkg} ..." "${log_base}.rhsm.out"
        bash -x -c "rpm -q --requires -p ${pkg}" | tee "${log_base}.rhsm.out"

        log_msg "Removing:\n\t${pkg} ..." "${log_base}.rhsm.out"
        bash -x -c "/bin/rm -fv ${pkg}" | tee "${log_base}.rhsm.out"
      done < <(find . -name '*.rpm' -print0)

    else
      log_msg "No RHSM packages found." "${log_base}.rhsm.out"
    fi
  fi

  sudo umount /media
fi
