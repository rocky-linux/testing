#!/bin/bash

set -e

function usage {
  printf "Usage: %s " "$(basename "${BASH_SOURCE[1]}")"
  printf "[-h] [-a x86_64|aarch64|ppc64le|s390x|src] [-s] [-c search|info|download] [others... see -h] [package(s)]\n"
  printf "\n"

  cat <<- "EOF"

  -h                        provide this help
  -a                        specify architecture for packages
                              x86_64 and aarch64 are available pre 9 while
                              ppc64le and s390x will be added for Rocky Linux 9
  -s                        source package
  -c                        specify dnf command
EOF
}



# Defaults
PDOT_ARCH="$(arch)"
PDOT_YUMREPOFS_HOST="$(yq .prod.host peridot_yumrepofs.yml)"
PDOT_PROJECT_ID="$(yq .prod.projectID peridot_yumrepofs.yml)"
PDOT_DNF_COMMAND="search"
PDOT_SOURCE_PACKAGE="false"

optstring="hsa:b:c:"

while getopts ${optstring} arg; do
  case ${arg} in
    h)
      usage
      exit 0
      ;;
    s)
      PDOT_SOURCE_PACKAGE="true"
      ;;
    c)
      PDOT_DNF_COMMAND="${OPTARG}"
      ;;
    a)
      PDOT_ARCH="${OPTARG}"
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

# The rest of the arguments are package names
shift "$((OPTIND -1))"
declare -a all_pkgs=()
for pkg in "$@"; do
  all_pkgs+=("${pkg}")
done

export PS4="# "

for pkg in "${all_pkgs[@]}"
do
  case "${PDOT_SOURCE_PACKAGE}" in
    true)
      set -x
      if [[ "${PDOT_DNF_COMMAND}" == "download" ]]; then
        dnf \
          --repofrompath=pdot-"${PDOT_ARCH},https://${PDOT_YUMREPOFS_HOST}/v1/projects/${PDOT_PROJECT_ID}/repo/all/src" \
          --repo=pdot-"${PDOT_ARCH}" \
          "${PDOT_DNF_COMMAND}" --source \
          "${pkg}"
      else
        dnf \
          --repofrompath=pdot-"${PDOT_ARCH},https://${PDOT_YUMREPOFS_HOST}/v1/projects/${PDOT_PROJECT_ID}/repo/all/src" \
          --repo=pdot-"${PDOT_ARCH}" \
          "${PDOT_DNF_COMMAND}" \
          "${pkg}"
      fi
      set +x
      ;;
    false)
      set -x
      dnf \
        --forcearch="${PDOT_ARCH}" \
        --repofrompath=pdot-"${PDOT_ARCH},https://${PDOT_YUMREPOFS_HOST}/v1/projects/${PDOT_PROJECT_ID}/repo/all/${PDOT_ARCH}" \
        --repo=pdot-"${PDOT_ARCH}" \
        "${PDOT_DNF_COMMAND}" \
        "${pkg}"
      set +x
      ;;
    *)
      ;;
  esac
done

exit $?
