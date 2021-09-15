#!/usr/bin/env bash

# Notes:
# - host under test must be installed with ${target} ${releasever}
# - dnf reposync for ${target} stored at repos/${target}/${releasever}/ relative
#   to this script to complete analysis.
# - reruns will skip if existing JSON output found, remove .json file(s) to
#   redo analysis
# - rpminspect --verbose output is captured in .rpminspect.out file and contains
#   general pass vs FAIL state of each test.
# - rpminspect JSON output is stored alongside the .rpminspect.out file and
#   contains full JSON output of all tests.
# - stderr of rpminspect goes to console, some packages may generate errors
#   during analysis and they should be manually checked.
#
#
# ==============================================================================
# Sample Rocky output (extras repo only)...
#
# [vagrant@rocky8u4 data]$ ./rpminspect_wrapper.sh
# Rocky Linux extras repo has...
#	     4 noarch packages ....
#
# ==============================================================================
# Sample CentOS output (extras repo only)...
#
# [vagrant@centos8u4 data]$ ./rpminspect_wrapper.sh
# CentOS Linux extras repo has...
# 	     2 x86_64 packages .
# 	cpaste-1.0.0.3.el8.x86_64 fail
# 	    32 noarch packages .....
# 	centos-release-configmanagement-1.1.el8.noarch fail ..........
# 	centos-release-openstack-train-2.1.el8.noarch fail
# 	centos-release-openstack-ussuri-1.5.el8.noarch fail
# 	centos-release-openstack-victoria-1.2.el8.noarch fail
# 	centos-release-opstools-1.10.el8.noarch fail .......
# 	centos-release-storage-common-2.2.el8.noarch fail
# 	centos-release-virt-common-1.2.el8.noarch fail ...
#
# ==============================================================================
# Sample RHEL output (rhel-8-for-x86_64-supplementary-rpms repo only)...
#
# [vagrant@rhel8u4 data]$ ./rpminspect_wrapper.sh
# Red Hat Enterprise Linux supplementary repo has...
# 	     9 x86_64 packages ....
# 		java-1.8.0-ibm-headless skipped
# 		....
# 	     2 noarch packages ..
#

set -e
#set -x

repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect

# shellcheck disable=SC1091
. /etc/os-release

target="${ID:-rocky}"
releasever="${VERSION_ID:-8.4}"
name="${NAME:-Rocky Linux}"

case $target in
	rocky)
		releasever="$(rpm -q --queryformat="%{VERSION}" rocky-release)"
		target_repos=(appstream baseos extras ha powertools resilient-storage)
		;;
	centos)
		releasever="$(rpm -q --queryformat="%{VERSION}" centos-linux-release)"
		#target_repos=(appstream baseos extras ha plus powertools)
		target_repos=(extras)
		;;
	rhel)
		releasever="$(rpm -q --queryformat="%{VERSION}" redhat-release)"
		target_repos=(codeready-builder-for-rhel-8-x86_64-rpms rhel-8-for-x86_64-appstream-rpms rhel-8-for-x86_64-baseos-rpms rhel-8-for-x86_64-highavailability-rpms rhel-8-for-x86_64-resilientstorage-rpms rhel-8-for-x86_64-supplementary-rpms)
		;;
	*)
		printf "%s\n" "$target is not supported"
		;;
esac

local_package_path="${repos_base}/${target}/${releasever}"

arch_list=(x86_64 i686 noarch)

for repo in "${target_repos[@]}"
do
	if [[ "${target}" = "rhel" ]]
	then
		case "${repo}" in
			codeready-builder-for-rhel-8-x86_64-rpms)
				 repo=$(printf "%s" "${repo}" | cut -d- -f1)
				 ;;
			*)
				repo=$(printf "%s" "${repo}" | cut -d- -f5)
				;;
		esac
	fi

	printf "%s %s repo has..." "${name}" "${repo}"
	for arch in "${arch_list[@]}"
	do

		local_packages=()
		while IFS="" read -r line
		do
			local_packages+=("$line")
		done < <(find "${local_package_path}/${repo}" -name "*${arch}.rpm" -type f | sort)

		if [[ ${#local_packages[@]} -gt 0 ]]
		then
			mkdir -p "${rpminspect_base}/${target}/${releasever}/${repo}"
			printf "\n\t%6d %s packages " "${#local_packages[@]}" "${arch}"

			for pkg in "${local_packages[@]}"
			do
				rpm_name=$(basename "${pkg}")
				pkg_name=$(rpm -q --queryformat="%{NAME}\n" "$pkg" 2>/dev/null)
				nvra_pkg_name=$(rpm -q --queryformat="%{NAME}-%{VERSION}.%{RELEASE}.%{ARCH}\n" "$pkg" 2>/dev/null)

				set +e
				# don't know why the python3-azure-sdk package hangs rpminspect... ignore it.
				# java-1.8.0-ibm-headless coredumps on runpath test... ignore it.
				if [[ "${pkg_name}" = "python3-azure-sdk" || "${pkg_name}" = "java-1.8.0-ibm-headless" ]]
				then
					printf "\n\t\t%s skipped\n\t\t" "${pkg_name}"
				else
					if [[ ! -f "${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.json" ]]
					then
						case "${target}" in
							rhel)
								rpm_first_char=$(echo "$rpm_name" | head -c 1)
								local_package_full_path="${local_package_path}/${repo}/Packages/${rpm_first_char}/${rpm_name}"
								;;
							*)
								local_package_full_path="${local_package_path}/${repo}/Packages/${rpm_name}"
								;;
						esac
						rpminspect-fedora -v -E metadata,files,patches,virus,javabytecode,disttag,specname \
							--format=json \
							--output="${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.json" \
							"${local_package_full_path}" \
							>"${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.rpminspect.out"

						ret=$?
						set -e
						if [[ $ret -ne 0 ]]
						then
							printf "\n\t%s fail " "${nvra_pkg_name}"
						else
							printf "."
						fi
					else
						printf "."
					fi
				fi
			done
		fi
	done
	printf "\n"
done

exit
