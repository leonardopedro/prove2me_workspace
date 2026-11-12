#!/usr/bin/env bash
# Compile the given Definitions/*.lean in the candidate mirror (state/mirror).
set -u
WS="$(cd "$(dirname "$0")/.." && pwd)"
MIRROR="${CANDIDATE_MIRROR:-$WS/state/mirror}"
PROJ="${TIMEPIECE_PROJ:-$WS/../timepiece331}"
BIN=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin
BASE=$(cd "$PROJ" && PATH="$BIN:$PATH" lake env bash -c 'printf %s "$LEAN_PATH"' 2>/dev/null)
LEAN=$(cd "$PROJ" && PATH="$BIN:$PATH" lake env bash -c 'command -v lean' 2>/dev/null)
[ -z "$LEAN" ] && { echo "no lean"; exit 2; }
rc=0
for f in "$@"; do
  m=$(basename "$f" .lean)
  cp "$WS/Definitions/$m.lean" "$MIRROR/Definitions/$m.lean"
  out=$(cd "$MIRROR" && PATH="$BIN:$PATH" LEAN_PATH="$MIRROR:$BASE" \
        "$LEAN" -DautoImplicit=false -o "Definitions/$m.olean" "Definitions/$m.lean" 2>&1)
  if [ $? -eq 0 ]; then echo "OK   $m"
  else echo "FAIL $m"; echo "$out" | grep -m3 "error"; rc=1; fi
done
exit $rc
