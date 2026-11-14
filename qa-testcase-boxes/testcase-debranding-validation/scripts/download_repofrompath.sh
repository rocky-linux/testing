#!/bin/bash

VER="10.3"
VER_MAJOR="10"
SUFFIX="-BETA"
ARCH="x86_64"

# From dl.r.o
CONTENT_DIR="stg/rocky"
REPO_BASE="http://download.rockylinux.org"
REPO_RELOCATE=""
REPO_BASE_DIR="${REPO_BASE}/${CONTENT_DIR}/${VER}${SUFFIX}"
DEVEL_REPO_BASE_DIR="${REPO_BASE_DIR}"
EXTRAS_REPO_BASE_DIR="${REPO_BASE_DIR}"

#${REPO_BASE}/${CONTENT_DIR}/${VER}${SUFFIX}/BaseOS/source/tree/
#${REPO_BASE}/${CONTENT_DIR}/${VER_MAJOR}/latest-Rocky-${VER_MAJOR}/compose/BaseOS/source/tree/

# From koji compose
#CONTENT_DIR="kojifiles/compose"
#REPO_BASE="https://kojidev.rockylinux.org"
##REPO_RELOCATE="/compose"
#REPO_BASE_DIR="${REPO_BASE}/${CONTENT_DIR}/${VER_MAJOR}/latest-Rocky-${VER_MAJOR}/compose/"
#DEVEL_REPO_BASE_DIR="${REPO_BASE}/${CONTENT_DIR}/${VER_MAJOR}/latest-Rocky-devel-${VER_MAJOR}/compose/"
#EXTRAS_REPO_BASE_DIR="${REPO_BASE}/${CONTENT_DIR}/${VER_MAJOR}/Extras-10.2-20260522.0/compose"

dnf download \
    --archlist=src \
    --disablerepo=* \
    --repofrompath="baseos-${VER}${SUFFIX}-src,${REPO_BASE_DIR}/BaseOS/source/tree/" \
    --repofrompath="appstream-${VER}${SUFFIX}-src,${REPO_BASE_DIR}/AppStream/source/tree/" \
    --repofrompath="crb-${VER}${SUFFIX}-src,${REPO_BASE_DIR}/CRB/source/tree/" \
    --repofrompath="devel-${VER}${SUFFIX}-src,${DEVEL_REPO_BASE_DIR}/devel/source/tree/" \
    --repofrompath="extras-${VER}${SUFFIX}-src,${EXTRAS_REPO_BASE_DIR}/extras/source/tree/" \
    --source $(awk '/src/ {print $2}' "r${VER}-combinations" | rev | cut -d\- -f3- | rev | sed 's/shim-x64/shim/')

dnf download \
    --archlist="${ARCH},noarch" \
    --disablerepo=* \
    --repofrompath="baseos-${VER}${SUFFIX},${REPO_BASE_DIR}/BaseOS/x86_64/os/" \
    --repofrompath="appstream-${VER}${SUFFIX},${REPO_BASE_DIR}/AppStream/x86_64/os/" \
    --repofrompath="crb-${VER}${SUFFIX},${REPO_BASE_DIR}/CRB/x86_64/os/" \
    --repofrompath="devel-${VER}${SUFFIX},${DEVEL_REPO_BASE_DIR}/devel/x86_64/os/" \
    --repofrompath="extras-${VER}${SUFFIX},${EXTRAS_REPO_BASE_DIR}/extras/x86_64/os/" \
    $(awk '!/src/ {print $2}' "r${VER}-combinations" | rev | cut -d\- -f3- | rev)
