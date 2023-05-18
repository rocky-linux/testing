#!/usr/bin/env bash

set -e
#set -x

repos_base=$(pwd)/repos
#rpminspect_base=$(pwd)/rpminspect
#urls_base=$(pwd)/urls

# shellcheck disable=SC1091
. /etc/os-release

tgt="${ID}"
releasever="${VERSION_ID}"

dnf clean all

case $tgt in
	rocky)
		tgt_repos=(appstream baseos devel extras ha powertools resilient-storage plus nfv rt)
		;;
	centos)
		releasever="$(rpm -q --queryformat="%{VERSION}" centos-linux-release)"
		tgt_repos=(appstream baseos extras ha plus powertools)
		;;
	rhel)
		printf "repos for %s must be sync'd on an entitled system" "${tgt}"
		#tgt_repos=(appstream baseos extras ha powertools resilient-storage)
		exit 1
		;;
	*)
		;;
esac

printf "Syncing %s Repos..." "${NAME}"

for repo in "${tgt_repos[@]}"
do
	printf " %s" "${repo}"
	dnf reposync --repoid="${repo}" --download-metadata --newest-only --download-path="${repos_base}/${tgt}/${releasever}/" >/dev/null
	touch ".$(basename -s .sh "$0").${tgt}.${releasever}.${repo}.touch"
done
printf "\n"

exit
