#!/usr/bin/env bash
# Elaborate one solution stub against the COMPILED candidate mirror.
#
# `debug/_one_sol.sh` prepends /tmp/published_mirror, which holds .lean sources
# without oleans: every `import Definitions.X` then fails with
# `object file ... does not exist` -- an oracle that reports a mirror artifact
# for every file, not a verdict.  The candidate mirror (debug/_one_def2.sh's
# state/mirror) DOES carry compiled oleans, so use it instead.
# Same base environment as the def checker: `lake env` in ../timepiece331.
set -u
WS=${WS:-/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/prove2me_workspace}
M=${SOL_MIRROR:-${CANDIDATE_MIRROR:-$WS/state/mirror}}
PROJ=${TIMEPIECE_PROJ:-$WS/../timepiece331}
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH
slug="${1%.lean}"; slug="${slug#Sol_}"
src="$WS/Solutions/Sol_${slug}.lean"
[ -f "$src" ] || { echo "MISSING $slug"; exit 0; }
base=$(cd "$PROJ" && lake env bash -c 'printf %s "$LEAN_PATH"')
lean=$(cd "$PROJ" && lake env bash -c 'command -v lean')
tmp=$(mktemp -d)
cp "$src" "$tmp/S.lean"
# -DautoImplicit=false: the server compiles with it, so a solution that leans on
# Lean's implicit binder for a name it never imported compiles here and fails
# there with `Unknown identifier`.  Measured 2026-11-06: four sols passed this
# harness and were rejected by the platform for exactly that (cxSystem,
# fockSectorCore, qgContinuumModes, characterSpace), all of which the previous
# command line rescued by autoImplicit.
LEAN_PATH="$M:$base" timeout "${SOL_TIMEOUT:-900}" "$lean" -DautoImplicit=false "$tmp/S.lean" >"$tmp/out" 2>&1
rc=$?
if [ $rc -eq 0 ]; then
  echo "OK $slug"
elif [ $rc -eq 124 ]; then
  echo "TIMEOUT $slug"
else
  echo "FAIL $slug $(grep -m1 -A1 error "$tmp/out" | tr '\n' ' ' | sed 's/.*error[^ ]* //' | cut -c1-100)"
  [ -n "${SOL_KEEP_LOG:-}" ] && cp "$tmp/out" "$SOL_KEEP_LOG"
fi
rm -rf "$tmp"
exit 0
