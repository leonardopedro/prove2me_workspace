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
# lean prints elaboration diagnostics on STDOUT — capture both, or every
# failure looks like an empty "FAIL <slug> " with no cause.
LEAN_PATH="/tmp/published_mirror:$base" timeout 600 "$lean" "$tmp/S.lean" >"$tmp/out" 2>"$tmp/err"
rc=$?
if [ $rc -eq 0 ]; then
  echo "OK $slug"
elif [ $rc -eq 124 ]; then
  echo "TIMEOUT $slug"
else
  err=$(grep -m1 -i error "$tmp/out" "$tmp/err" 2>/dev/null | sed 's/^.*error[^ ]*: //' | cut -c1-100)
  echo "FAIL $slug :: $err"
fi
exit 0
rm -rf "$tmp"
