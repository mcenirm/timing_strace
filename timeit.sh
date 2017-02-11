#!/bin/bash

set -e

scripts=$( cd "$(dirname "$0")" && /bin/pwd )
timings=${PWD}/timings.$(date +%s)

for filter in none all process accept ; do
  traces=${timings}/traces.${filter}
  if [ "$filter" = none ] ; then
    runner=()
  else
    runner=( strace -ff -o "$traces"/trace )
    if ! [ "$filter" = all ] ; then
      runner+=( -e "$filter" )
    fi
  fi
  out=${timings}/${filter}.out
  err=${out%.out}.err
  mkdir -p "$traces"
  "${scripts}/cleanit.sh" >> "$out" 2>> "$err"
  (
    /usr/bin/time -f "$filter %e %U %S" "${runner[@]}" "${scripts}/buildit.sh"
  ) >> "$out" 2>> "$err"
  tail -n 1 "${timings}/${filter}.err" | tee -a "${timings}/timings.txt"
done
