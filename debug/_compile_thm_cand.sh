#!/usr/bin/env bash
set -u
M=/tmp/def_candidate
PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace/../timepiece331
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
m="$1"
[ -f "$M/Theorems/$m.lean" ] || { echo "NOSRC $1"; exit 0; }
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
(cd "$M" && LEAN_PATH="$M:$base" timeout 900 "$lean" -o "Theorems/$m.olean" "Theorems/$m.lean") >/tmp/ot_$m 2>&1
rc=$?
if [ $rc -eq 0 ]; then echo "OK $1"
else echo "FAIL $1 $(grep -m1 -A1 error /tmp/ot_$m | tr '\n' ' ' | sed 's/.*error[^ ]* //' | cut -c1-80)"; fi
rm -f /tmp/ot_$m
exit 0
