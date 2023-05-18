#!/usr/bin/env bash

# Notes:
# - host under test must be installed with ${target} ${releasever}
# - dnf reposync for ${target} stored at repos/${target}/${releasever}/ relative
#   to this script to complete analysis.
# - reruns will skip if existing json output found, remove to re-analyze
# - rpminspect --verbose output is captured in .rpminspect.out file and contains
#   general pass vs FAIL state of each test.
# - rpminspect JSON output is stored alongside the .rpminspect.out file and
#   contains full JSON output of all tests.
# - stderr of rpminspect is stored alongside the rpminspect.out file as
#   rpminspect.err. Some packages may generate errors during analysis and they
#   should be manually checked.
#
#
# ==============================================================================
# Sample Rocky output (plus, nfv and tr repos only)...
#
# [vagrant@rocky8u4 data]$ ./rpminspect_wrapper.sh
#Rocky Linux plus repo has...
#	     3 x86_64 packages -
#		openldap-servers-2.4.46-17.el8_4.x86_64 fail \
#		openldap-servers-2.4.46-18.el8.x86_64 fail |
#		thunderbird-91.3.0-2.el8.plus.x86_64 fail
#Rocky Linux nfv repo has...
#	    38 x86_64 packages /
#	     7 noarch packages \
#Rocky Linux rt repo has...
#	    26 x86_64 packages -
#		kernel-rt-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail \
#		kernel-rt-core-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail |
#		kernel-rt-debug-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail /
#		kernel-rt-debug-core-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail -
#		kernel-rt-debug-devel-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail \
#		kernel-rt-debug-modules-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail |
#		kernel-rt-debug-modules-extra-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail /
#		kernel-rt-devel-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail -
#		kernel-rt-modules-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail \
#		kernel-rt-modules-extra-4.18.0-305.25.1.rt7.97.el8_4.x86_64 fail |
#		kernel-rt-4.18.0-348.rt7.130.el8.0.2.x86_64 fail /
#		kernel-rt-core-4.18.0-348.rt7.130.el8.0.2.x86_64 fail -
#		kernel-rt-debug-4.18.0-348.rt7.130.el8.0.2.x86_64 fail \
#		kernel-rt-debug-core-4.18.0-348.rt7.130.el8.0.2.x86_64 fail |
#		kernel-rt-debug-devel-4.18.0-348.rt7.130.el8.0.2.x86_64 fail /
#		kernel-rt-devel-4.18.0-348.rt7.130.el8.0.2.x86_64 fail -
#		rteval-loads-1.4-11.el8.x86_64 fail /
#		stress-ng-0.12.06-2.el8.x86_64 fail -
#		stress-ng-0.11.10-4.el8.x86_64 fail
#	     4 noarch packages |
#		rteval-3.1-5.el8_4.noarch fail \
#		tuned-profiles-realtime-2.15.0-2.el8_4.1.noarch fail
#

set -e
#set -x

repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect

# shellcheck disable=SC1091
. /etc/os-release

target="${ID:-rocky}"
releasever="${VERSION_ID:-8.5}"
name="${NAME:-Rocky Linux}"

case $target in
	rocky)
		releasever="$(rpm -q --queryformat="%{VERSION}" rocky-release)"
		target_repos=(appstream baseos extras ha powertools resilient-storage plus nfs rt)
		;;
	centos)
		releasever="$(rpm -q --queryformat="%{VERSION}" centos-linux-release)"
		target_repos=(appstream baseos extras ha plus powertools)
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

	printf "%s %s repo has... " "${name}" "${repo}"
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
			printf "\b\n\t%6d %s packages\t" "${#local_packages[@]}" "${arch}"

			i=1
			sp="/-\|"
			for pkg in "${local_packages[@]}"
			do
				# shellcheck disable=SC2059
				printf "\b${sp:i++%${#sp}:1}"
				rpm_name=$(basename "${pkg}")
				pkg_name=$(rpm -q --queryformat="%{NAME}\n" "$pkg" 2>/dev/null)
				#nvra_pkg_name=$(rpm -q --queryformat="%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n" "$pkg" 2>/dev/null)
				#nvra_pkg_name=$(basename -s .rpm "$pkg" 2>/dev/null)
				nvra_pkg_name=$(rpm -qp "$pkg" 2>/dev/null)

				set +e
				# not sure why the python3-azure-sdk package takes so long (29m25.703s)
				# and it's exists in two repositories. See the single custom run results and ignore it.
				# java-1.8.0-ibm-headless coredumps on runpath test... ignore it. NOTE: It's gone in 8.5 but leve here until we never test 8.4 again.
				if [[ "${pkg_name}" = "python3-azure-sdk" || "${pkg_name}" = "java-1.8.0-ibm-headless" ]]
				then
					# shellcheck disable=SC2059
					printf "\b\n\t\t%s skipped\n\t\t" "${pkg_name}"
				else
					rpminspect_bin=rpminspect-fedora

					# these only make sense for src rpm validation
					#rpminspect_srpm_only="disttag,files,patches,specname"

					# these only make sense when comparing before to after builds
					#rpminspect_before_after_only="addedfiles,changedfiles,files,filesize,movedfiles,removedfiles"

					# desktop excluded due to huge number of desktop files messages requiring validation, round 2?
					# license excluded due to Redhat commercial license and no redhat.yaml file (no rpminspect-data-redhat even though it's their tool)
					# metadata excluded due to the fact that Redhat build servers are unknown
					# virus excluded for expedience, round 2?
					#rpminspect_exclude="${rpminspect_srpm_only},${rpminspect_before_after_only},desktop,license,metadata,virus"

					# alternately, provide an explicit list of test to include
					rpminspect_include="emptyrpm,manpage,xml,elf,modularity,javabytecode,ownership,shellsyntax,annocheck,permissions,capabilities,pathmigration,lto,symlinks,politics,badfuncs,runpath"

					if [[ ! -f "${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.json" ]]
					then
						case "${target}" in
							centos)
								local_package_full_path="${local_package_path}/${repo}/Packages/${rpm_name}"
								;;
							rhel)
								rpm_first_char=$(echo "$rpm_name" | head -c 1)
								local_package_full_path="${local_package_path}/${repo}/Packages/${rpm_first_char}/${rpm_name}"
								;;
							rocky)
								rpminspect_bin=rpminspect-rocky
								#rpminspect_exclude="addedfiles,files,patches,virus,disttag,specname"
								rpm_first_char=$(echo "$rpm_name" | head -c 1)
								local_package_full_path="${local_package_path}/${repo}/Packages/${rpm_first_char}/${rpm_name}"
								;;
							*)
						 		;;
						esac
							#"${rpminspect_bin}" -v -E "${rpminspect_exclude}" \
							"${rpminspect_bin}" -v -T "${rpminspect_include}" \
								--format=json \
								--output="${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.json" \
								"${local_package_full_path}" \
								>"${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.rpminspect.out" \
							2>"${rpminspect_base}/${target}/${releasever}/${repo}/${nvra_pkg_name}.rpminspect.err"
						ret=$?
						set -e
						if [[ $ret -ne 0 ]]
						then
							printf "\b\b\n\t\t%s fail  " "${nvra_pkg_name}"
						else
							# shellcheck disable=SC2059
							printf "\b${sp:i++%${#sp}:1}"
						fi
					else
						# shellcheck disable=SC2059
						printf "\b${sp:i++%${#sp}:1}"
					fi
				fi
			done
		fi
	done
	printf "\n"
	touch ".$(basename -s .sh "$0").${target}.${releasever}.${repo}.touch"
done

exit
