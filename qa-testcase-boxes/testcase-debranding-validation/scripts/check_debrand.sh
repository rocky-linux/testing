#!/usr/bin/env bash

echo -e "======== DEBRANDED PKGS ========"
mapfile -t debrand_pkgs < <(yq '.debrand.r8 + .debrand.all | sort() | .[]' patch.yml | tr '\n' ' ')

for pkg in "${debrand_pkgs[@]}"
do
  koji list-builds --after=2022-05-10T00:00:00 --quiet --owner=distrobuild --package="${pkg}" --reverse | head -n 1
  koji list-builds --after=2022-05-10T00:00:00 --quiet --owner=mbs --package="${pkg}" --reverse | head -n 1
done
