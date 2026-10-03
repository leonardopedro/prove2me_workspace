#!/usr/bin/env bash
# Elaborate one Theorems/* module inside the published mirror, deps-first.
set -u
M=/tmp/published_mirror
PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace/../timepiece331
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
mod="$1"
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
src="$M/Theorems/$mod.lean"
[ -f "$src" ] || { echo "NOSRC $mod"; exit 0; }
# satisfy any Definitions import first
for d in $(grep -oE '^import Definitions\.Def_\S+' "$src" | sed 's/.*Def_//'); do
  [ -f "$M/Definitions/Def_$d.olean" ] || echo "  (def $d not compiled)"
done
# Lean requires the -o target inside its root, so compile from the mirror
# with relative paths, the way build_published_mirror.py does.
(cd "$M" && LEAN_PATH="$M:$base" timeout 900 "$lean" -o "Theorems/$mod.olean" "Theorems/$mod.lean") >/dev/null 2>/tmp/e_$mod
rc=$?
if [ $rc -eq 0 ]; then echo "OK $mod"
elif [ $rc -eq 124 ]; then echo "TIMEOUT $mod"
else echo "FAIL $mod $(grep -m1 error /tmp/e_$mod | sed 's/.*error[^ ]* //' | cut -c1-80)"; fi
rm -f /tmp/e_$mod
exit 0
