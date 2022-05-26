#!/bin/bash

set -e

PDOT_ARCH="${PDOT_ARCH:-$(arch)}"
PDOT_YUMREPOFS_HOST="${PDOT_HOST:-$(yq .prod.host peridot_yumrepofs.yml)}"
PDOT_PROJECT_ID="${PROJECT_ID:-$(yq .prod.projectID peridot_yumrepofs.yml)}"
PDOT_DNF_COMMAND="${DNF_COMMAND:-search}"
PDOT_PACKAGE="${1:-thunderbird}"

export PS4="# "

case "${PDOT_ARCH}" in
  src)
    set -x
    PDOT_ARCH="x86_64"
    dnf \
      --repofrompath=pdot-"${PDOT_ARCH},https://${PDOT_YUMREPOFS_HOST}/v1/projects/${PDOT_PROJECT_ID}/repo/all/${PDOT_ARCH}" \
      --repo=pdot-"${PDOT_ARCH}" \
      "${PDOT_DNF_COMMAND}" \
      "${PDOT_PACKAGE}"
    set +x
    ;;
  *)
    set -x
    dnf \
      --forcearch="${PDOT_ARCH}" \
      --repofrompath=pdot-"${PDOT_ARCH},https://${PDOT_YUMREPOFS_HOST}/v1/projects/${PDOT_PROJECT_ID}/repo/all/${PDOT_ARCH}" \
      --repo=pdot-"${PDOT_ARCH}" \
      "${PDOT_DNF_COMMAND}" \
      "${PDOT_PACKAGE}"
    set +x
    ;;
esac

exit $?
