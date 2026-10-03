#!/usr/bin/env bash
# Elaborate one Definitions/* module inside the published mirror, deps-first.
set -u
M=/tmp/published_mirror
PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace/../timepiece331
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
d="$1"
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
[ -f "$M/Definitions/$d.lean" ] || { echo "NOSRC $d"; exit 0; }
(cd "$M" && LEAN_PATH="$M:$base" timeout 900 "$lean" -o "Definitions/$d.olean" "Definitions/$d.lean") >/dev/null 2>/tmp/ed_$d
rc=$?
if [ $rc -eq 0 ]; then echo "OK $d"
elif [ $rc -eq 124 ]; then echo "TIMEOUT $d"
else echo "FAIL $d $(grep -m1 error /tmp/ed_$d | sed 's/.*error[^ ]* //' | cut -c1-70)"; fi
rm -f /tmp/ed_$d
exit 0
