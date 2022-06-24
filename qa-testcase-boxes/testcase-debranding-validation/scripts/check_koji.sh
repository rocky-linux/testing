#!/usr/bin/env bash

echo -e "======== ACTIVE BUILDING ======="
koji list-builds --quiet --state=BUILDING | wc -l
echo ""

echo -e "===== DISTROBUILD COMPLETE ====="
koji list-builds --after=2022-05-10T00:00:00 --owner=distrobuild --state=COMPLETE | wc -l
echo ""

echo -e "========= MBS COMPLETE ========="
koji list-builds --after=2022-05-10T00:00:00 --owner=mbs --state=COMPLETE | wc -l
echo ""
