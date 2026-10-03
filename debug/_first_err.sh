#!/usr/bin/env bash
# §5d: read the FIRST error for one stub. That is the only reliable signal.
set -u
M=/tmp/published_mirror
PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace/../timepiece331
WS=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
s="$1"; f="$WS/Theorems/Thm_$s.lean"
[ -f "$f" ] || { echo "NOSRC $s"; exit 0; }
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
LEAN_PATH="$M:$base" timeout 600 "$lean" "$f" 2>&1 | grep -m1 -A2 "error" | tr '\n' ' ' | sed 's/  */ /g' | cut -c1-190
echo ""
exit 0
