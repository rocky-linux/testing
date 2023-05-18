#!/usr/bin/env bash

# Notes:
# - host under test must be installed with ${tgt} ${releasever}
# - rpminspect JSON output is stored alongside the .rpminspect.out file and
#   contains full JSON output of all tests.
#

set -e
#set -x

repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect

# shellcheck disable=SC1091
. /etc/os-release

tgt="${ID:-rocky}"
releasever="${VERSION_ID:-8.5}"

printf "\n=====\n Summary of all tests for %s version %s...\n\n" "${tgt}" "${releasever}"
wc -l "${rpminspect_base}/${tgt}/${releasever}/${tgt}_pass"
wc -l "${rpminspect_base}/${tgt}/${releasever}/${tgt}_fail"

for state in fail pass
do
	printf "\n=====\n Summary of %sing tests...\n" "${state}"
	awk '{c[$1]++;} END {for (i in c) print c[i],i}' "${rpminspect_base}/${tgt}/${releasever}/${tgt}_${state}" | \
		sort -k1,1nr | \
		while read -r total repo; do
			printf "\n-----\n%s had %d %sing tests with the following breakdown...\n" "${repo}" "${total}" "${state}"
			grep -E "^${repo}[[:space:]]" "${rpminspect_base}/${tgt}/${releasever}/${tgt}_${state}" | \
				awk '{c[$3]++;} END {for (i in c) printf("\t%d %s\n",c[i],i)}' | \
				sort -k1,1nr
		done
done

repos=$(cd "${repos_base}/${tgt}/${releasever}" && for d in $(find . -mindepth 1 -maxdepth 1 -type d | sort); do printf "%s " "$(basename "$d")"; done; printf "\n")
for state in fail pass
do
	for repo in ${repos}
	do
		printf "\n-----\n %s repository %sing tests...\n-----\n" "${repo}" "${state}"
		grep -E "[[:space:]]${repo}[[:space:]]" "${rpminspect_base}/${tgt}/${releasever}/${tgt}_${state}" | \
			awk '{t[$3]++} END {for (i in t) print t[i],i;}' \
			"${rpminspect_base}/${tgt}/${releasever}/${tgt}_${state}" | \
			sort -k1,1nr | \
			column -t
	done
done

touch ".$(basename -s .sh "$0").${tgt}.${releasever}.touch"
