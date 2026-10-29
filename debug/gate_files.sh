#!/usr/bin/env bash
# Compile each given .lean file the way the platform gates it: LEAN_PATH =
# /tmp/published_mirror (published def+thm oleans) : base (lake env of
# timepiece331, supplies Mathlib). Prints `OK <file>` or `FAIL <file>` plus the
# first few diagnostics. Usage: debug/gate_files.sh path/to/A.lean [more...]
set -u
WS="$(cd "$(dirname "$0")/.." && pwd)"
PROJ="${TIMEPIECE_PROJ:-$WS/../timepiece331}"
export PATH="/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH"
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
export LEAN_PATH="/tmp/published_mirror:$base"
rc_total=0
for f in "$@"; do
  [ -f "$f" ] || { echo "MISSING $f"; rc_total=1; continue; }
  tmp=$(mktemp -d)
  cp "$f" "$tmp/S.lean"
  # lean 4.33 refuses inputs outside the working-directory root, so run it
  # from inside $tmp rather than from the workspace.
  (cd "$tmp" && timeout 600 "$lean" -o S.olean S.lean >out 2>&1)
  rc=$?
  if [ $rc -eq 0 ]; then
    echo "OK   $f"
  elif [ $rc -eq 124 ]; then
    echo "TIMEOUT $f"; rc_total=1
  else
    echo "FAIL $f"
    msg=$(grep -i "error" "$tmp/out" | head -4)
    [ -n "$msg" ] || msg=$(grep -v '^$' "$tmp/out" | head -4)
    printf '%s\n' "$msg" | sed 's/^/     /'
    rc_total=1
  fi
  rm -rf "$tmp"
done
exit $rc_total
