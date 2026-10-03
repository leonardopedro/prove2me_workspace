#!/usr/bin/env bash
# Compile one def bundle inside the candidate mirror; used in dependency order.
set -u
WS=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
M=/tmp/def_candidate
PROJ=$WS/../timepiece331
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
# Accept EITHER a chapter name or a full module id, so callers can pass whichever
# list they hold without prepending Def_ twice.
case "$1" in
  Def_*) d="$1" ;;
  *)     d="Def_$1" ;;
esac
[ -f "$M/Definitions/$d.lean" ] || { echo "NOSRC $1"; exit 0; }
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
(cd "$M" && LEAN_PATH="$M:$base" timeout 900 "$lean" -o "Definitions/$d.olean" "Definitions/$d.lean") >/tmp/o_$d 2>&1
rc=$?
if [ $rc -eq 0 ]; then echo "OK ${d#Def_}"
elif [ $rc -eq 124 ]; then echo "TIMEOUT ${d#Def_}"
else echo "FAIL ${d#Def_} $(grep -m1 -A1 error /tmp/o_$d | tr '\n' ' ' | sed 's/.*error[^ ]* //' | cut -c1-84)"; fi
rm -f /tmp/o_$d
exit 0
