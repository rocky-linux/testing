#!/usr/bin/env bash

# Notes:
# - host under test must be installed with ${target} ${releasever}
# - rpminspect JSON output is stored alongside the .rpminspect.out file and
#   contains full JSON output of all tests.
#

set -e
#set -x

#repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect

# shellcheck disable=SC1091
. /etc/os-release

target="${ID:-rocky}"
releasever="${VERSION_ID:-8.5}"

for state in pass fail
do
	grep -iH "${state}" "${rpminspect_base}/${target}/${releasever}/*/*.out" | \
		tr ':' ' ' | tr '/' ' ' | sed 's/inspect.out//g' | \
		awk '{print $7,$8,$10,$12}' > \
		"${rpminspect_base}/${target}/${releasever}/${target}_${state}"
	touch ".$(basename -s .sh "$0").${target}.${releasever}.${state}"
done
wc -l "${rpminspect_base}/${target}/${releasever}/${target}*"

