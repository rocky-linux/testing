#!/usr/bin/env bash

set -e
#set -x

repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect

# shellcheck disable=SC1091
. /etc/os-release

src="${SRC:-rhel}"
tgt="${ID:-rocky}"
releasever="${VERSION_ID:-8.5}"

state="${1:fail}"
state_msg=""
if [[ "${state}" == "pass" ]]
then
	state_msg="PASSES"
else
	state_msg="FAILURES"
fi

diff_out="${src}_vs_${tgt}_${releasever}.${state}.diffs"
match_out="${src}_vs_${tgt}_${releasever}.${state}.matches"

printf "=====\n%s started at %s for %s\n=====\n" "$0" "$(date)" "${state_msg}" | \
	tee "${diff_out}" | \
	tee "${match_out}"

no_pkg_found="false"
last_pkg=""
while read -r repo pkg test status
do
	if [[ "${state,,}" != "${status,,}" ]]
	then
					continue
	fi

	if [[ "${last_pkg}" == "${pkg}" && "${no_pkg_found}" == "true" ]]
	then
		continue
	fi
	rpm_pkg=$(find "${repos_base}/${tgt}/${releasever}/${repo}" -name "${pkg}*")
	#pkg_n_v_r_a=$(rpm -q --queryformat="%{NAME} %{VERSION} %{RELEASE} %{ARCH}\n" -p "${rpm_pkg}")
	pkg_nvra=$(rpm -q --queryformat="%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}\n" -p "${rpm_pkg}")
	#pkg_nvr=$(rpm -q --queryformat="%{NAME}-%{VERSION}-%{RELEASE}\n" -p "${rpm_pkg}")
	pkg_nv=$(rpm -q --queryformat="%{NAME}-%{VERSION}\n" -p "${rpm_pkg}")
	#pkg_n=$(rpm -q --queryformat="%{NAME}\n" -p "${rpm_pkg}")
	#pkg_v=$(rpm -q --queryformat="%{VERSION}\n" -p "${rpm_pkg}")
	pkg_r=$(rpm -q --queryformat="%{RELEASE}\n" -p "${rpm_pkg}")
	declare -a pkg_r_parts
	readarray -d . -t pkg_r_parts<<<"$pkg_r"
		pkg_a=$(rpm -q --queryformat="%{ARCH}" -p "${rpm_pkg}")
		tgt_repo="${repo}"
		src_repo=""

	case $tgt_repo in
		extras)
			src_repo="*"
			;;
		powertools)
			src_repo="codeready"
			;;
		codeready)
			src_repo="powertools"
			;;
		ha)
			src_repo="highavailability"
			;;
		highavailability)
			src_repo="ha"
			;;
		resilient-storage)
			src_repo="resilientstorage"
			;;
		resilientstorage)
			src_repo="resilient-storage"
			;;
		*)
			src_repo="$tgt_repo"
			;;
	esac

	set -e
	tgt_file=$(find "${rpminspect_base}/${tgt}/${releasever}/${tgt_repo}" -name "${pkg_nvra}.json")
	set +e
	src_file=$(find "${rpminspect_base}/${src}/${releasever}/${src_repo}" -name "${pkg_nvra}.json" 2>/dev/null)
	src_file_cnt=$( (($(printf "%s\n" "${src_file}" | wc -w) + 0)) )
	if [[ $src_file_cnt -gt 1 ]]
	then

		# TODO: We may get more than one match here and we need to sensibly pick one to compare against
		#       How???? Maybe compare the lates modular package with the same version based on BUILDTIME?
		#
		# foo=$(find /home/vagrant/data/repos/rhel/8.5/appstream -name 'bea-stax-api-1.2.0-16*noarch.rpm')
		# rpm -q --queryformat="%{NAME}-%{VERSION}-%{RELEASE}.%{ARCH}.rpm %{BUILDTIME}\n" $(printf "%s\n" ${foo} | sort -V)
		# bea-stax-api-1.2.0-16.module+el8+2468+c564cec5.noarch.rpm 1544713419
		# bea-stax-api-1.2.0-16.module+el8.0.0+3892+c903d3f0.noarch.rpm 1565144771
		# bea-stax-api-1.2.0-16.module+el8.1.0+3366+6dfb954c.noarch.rpm 1560355487

		# FOR NOW... we'll bail
		echo "${tgt}/${releasever}/${tgt_repo}/$(basename -s .json "${tgt_file}").rpm MULTIPLE_TARGET_PACKAGES_IN ${tgt}/${releasever}/${tgt_repo}"
		continue
	fi

	if test -z "${tgt_file}"
	then
		# For modular packages add only the first nibble of the ${RELEASE} identifier and try to find a match
		src_file=$(find "${rpminspect_base}/${src}/${releasever}/${src_repo}" -name "${pkg_nv}-${pkg_r_parts[0]}*${pkg_a}.json" 2>/dev/null)
		if test -z "${tgt_file}"
		then
			src_file=$(find "${rpminspect_base}/${src}/${releasever}" -name "${pkg_nv}*${pkg_a}.json" 2>/dev/null)
			src_file_cnt=$( (( $(printf "%s\n" "${src_file}" | wc -w) + 0 )) )
			if [[ $src_file_cnt -gt 1 ]]
			then
				echo "${tgt}/${releasever}/${tgt_repo}/$(basename -s .json "${tgt_file}").rpm MULTIPLE_TARGET_PACKAGES_IN ${tgt}/${releasever}/${tgt_repo}"
				continue
			fi
			# If we climbed back up the tree we aren't searching in a specific tgt_repo anymore...
			tgt_repo=""
		fi
	fi

	tgt_basename="$(basename -s .json "${tgt_file}")"
	src_basename="$(basename -s .json "${src_file}")"

	# Check to make sure we have a target to compare to...
	if [[ -f "${src_file}" ]]
	then
		# At this point we may have climbed back up the (inverted) target repo tree to find a match, for
		# example...
		#
		# tgt_file: /home/vagrant/data/rpminspect/rocky/8.5/plus/openldap-servers-2.4.46-17.el8_4.x86_64.json
		# src_file: /home/vagrant/data/rpminspect/rhel/8.5/codeready/openldap-servers-2.4.46-9.el8.x86_64.json
		#
		# ...we need to extract the ${src_repo} from the ${src_file} path...
		new_src_repo=$(basename "$(dirname "${src_file}")")
		if [ "${new_src_repo}" != "${src_repo}" ]
		then
			src_repo="${new_src_repo}"
		fi

		# Here we don't compare the whole file because we know it will not be the same as full path
		# to package is included, rpminspect version may different in rocky and rhel, ...
		#result=$(diff -s <(jq --sort-keys .""${test}"" "${tgt_file}") <(jq --sort-keys .""${test}"" "${src_file}"))
		#result=$(diff -s -w <(jq -r --sort-keys .""${test}"" "${tgt_file}" | grep -Ev "annocheck: Version") <(jq -r --sort-keys .""${test}"" "${src_file}" | grep -Ev "annocheck: Version"))
		#result=$(diff -s <(jq --sort-keys .""${test}"" "${tgt_file}") <(jq --sort-keys .""${test}"" "${src_file}"))

		jqls=$(mktemp -p /dev/shm)
		jqrs=$(mktemp -p /dev/shm)

		case $test in
			javabytecode)
				jq --arg test "${test}" -r --sort-keys '.[$test] | sort_by(.message)' "${tgt_file}" | grep -Ev "annocheck: Version" > "$jqls"
				jq --arg test "${test}" -r --sort-keys '.[$test] | sort_by(.message)' "${src_file}" | grep -Ev "annocheck: Version" > "$jqrs"
				;;
			*)
				jq --arg test "${test}" -r --sort-keys '.[$test]' "${tgt_file}" | grep -Ev "annocheck: Version" > "$jqls"
				jq --arg test "${test}" -r --sort-keys '.[$test]' "${src_file}" | grep -Ev "annocheck: Version" > "$jqrs"
				;;
		esac

		# compare the JSON of the two tests while ignoring white space
		diff -s -w "${jqls}" "${jqrs}" >/dev/null 2>&1
		ret=$?
		if [[ $ret -ne 0 ]]
		then
			printf "\n=====\n\t%s test %s are DIFFERENT between...\n" "${test}" "${state_msg}" >> "${diff_out}"
			printf "%s %s %s_DIFFERENT %s\n" \
				"${tgt}/${releasever}/${tgt_repo}/${tgt_basename}.rpm" \
				"${test}" "${state_msg}" \
				"${src}/${releasever}/${src_repo}/${src_basename}.rpm"
			printf "  src_file: %s\n  tgt_file: %s\n\n" "${src_file}" "${tgt_file}" >> "${diff_out}"

			#diff --suppress-common-lines -w <(jq -r --sort-keys .""${test}"" "${tgt_file}" | grep -Ev \"annocheck: Version\") <(jq -r --sort-keys .""${test}"" "${src_file}" | grep -Ev "annocheck: Version") | \
			#We were filtering before
			#grep -Ev "PASS:|skip:|info:|debug:|annobin plugin was built" \

			diff --suppress-common-lines -w "${jqls}" "${jqrs}" | \
				sed 's,\\n,\n,g' | \
				grep -Ev "skip:|info:|debug:|annobin plugin was built" \
				>>"${diff_out}"
		else
			printf "%s %s %s_MATCH %s\n" \
				"${tgt}/${releasever}/${tgt_repo}/${tgt_basename}.rpm" \
				"${test}" \
				"${state_msg}" \
				"${src}/${releasever}/${src_repo}/${src_basename}.rpm" | \
				tee -a "${match_out}"
		fi
		rm "${jqls}" "${jqrs}"
		no_pkg_found="false"
	else
		printf "%s %s %s\n" \
			"${tgt}/${releasever}/${tgt_repo}/${tgt_basename}.rpm" \
			"NO_TARGET_PACKAGE_IN" \
			"${src}/${releasever}/${src_repo}"
		no_pkg_found="true"
	fi
	last_pkg="${pkg}"
done < <(grep -v '^ *#' < "${rpminspect_base}/${tgt}/${releasever}/${tgt}_${state}")

printf "=====\n%s ended at %s for %s\n=====" "$0" "$(date)" "${state_msg}" | \
	tee "${diff_out}" | \
	tee "${match_out}"

touch ".$(basename -s .sh "$0").${tgt}.${releasever}.${state}.touch"
