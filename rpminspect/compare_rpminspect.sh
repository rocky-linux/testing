#!/usr/bin/env bash

src="${SRC:-rocky}"
tgt="${TGT:-rhel}"

while read -r pkg test status
do
  src_file=$(find "rpminspect/${src}/8.4" -name "${pkg}")
  tgt_file=$(find "rpminspect/${tgt}/8.4" -name "${pkg}")

  if [[ -f "${tgt_file}" ]]
  then
    diff -q "${src_file}" "${tgt_file}" >/dev/null 2>&1
    if [[ $? -eq 1 ]]
    then
      echo "$test $status in $src_file and $tgt_file"
      sdiff -s "${src_file}" "${tgt_file}"
    fi
  else
    echo "${pkg} absent in ${tgt}"
  fi
done < <(grep -v '^ *#' < "${src}_fail")
