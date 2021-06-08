#!/usr/bin/env bash

#set -e
#set -x

repos_base=$(pwd)/repos
rpminspect_base=$(pwd)/rpminspect
urls_base=$(pwd)/urls

. /etc/os-release

target="${ID}"
releasever="${VERSION_ID}"
name="${NAME}"

# TODO: complete cleanup of script...
