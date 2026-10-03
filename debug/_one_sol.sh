#!/usr/bin/env bash
# Elaborate one solution stub the way the platform does (autoImplicit false).
set -u
WS="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace"
PROJ="$WS/../timepiece331"
export PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH"
slug="$1"
src="$WS/Solutions/Sol_${slug}.lean"
[ -f "$src" ] || { echo "MISSING $slug"; exit 0; }
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
tmp=$(mktemp -d)
cp "$src" "$tmp/S.lean"
LEAN_PATH="/tmp/published_mirror:$base" timeout 600 "$lean" "$tmp/S.lean" >/dev/null 2>"$tmp/err"
rc=$?
if [ $rc -eq 0 ]; then
  echo "OK $slug"
elif [ $rc -eq 124 ]; then
  echo "TIMEOUT $slug"
else
  echo "FAIL $slug $(grep -m1 error "$tmp/err" | sed 's/.*error[^ ]* //' | cut -c1-90)"
fi
exit 0
rm -rf "$tmp"
