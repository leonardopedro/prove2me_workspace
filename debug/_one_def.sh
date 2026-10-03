#!/usr/bin/env bash
# Compile one generated def bundle in a candidate mirror, deps-first.
set -u
WS=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
M=/tmp/def_candidate
PROJ=$WS/../timepiece331
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
d="Def_$1"
src="$WS/Definitions/$d.lean"
[ -f "$src" ] || { echo "NOSRC $1"; exit 0; }
mkdir -p "$M/Definitions"
[ -f "$M/$d.lean" ] || cp "$src" "$M/$d.lean"
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
(cd "$M" && LEAN_PATH="$M:$base" timeout 900 "$lean" -o "Definitions/$d.olean" "Definitions/$d.lean") >/tmp/edout_$d 2>&1
rc=$?
if [ $rc -eq 0 ]; then echo "OK $1"
elif [ $rc -eq 124 ]; then echo "TIMEOUT $1"
else echo "FAIL $1 $(grep -m1 -A1 error /tmp/edout_$d | tr "\n" ' ' | sed 's/.*error[^ ]* //' | cut -c1-90)"; fi
rm -f /tmp/edout_$d
exit 0
