#!/usr/bin/env bash
# Stage a set of def bundles into the published mirror until NO new module
# builds in a full pass (fixpoint).
#
# `stage_def_mirror.py` compiles in reverse-BFS order, which is deps-first for
# shallow graphs but not for shared/cross-layer deps: one pass leaves the
# importers whose dependency was discovered late.  Re-running builds exactly
# those (the already-built prune at the .olean), so the pass count is the
# depth of the bad ordering -- measured 28/142, then 12/114, then ... until a
# pass adds nothing.
#
# Usage: bash debug/stage_until_fixpoint.sh <chapters-file> [max-passes]
#   chapters-file: one chapter name per line (Def_ prefix optional)
set -u
cd "$(dirname "$0")/.."
LIST=$1
MAX=${2:-8}
LOGDIR=state
for i in $(seq 1 "$MAX"); do
  before=$(find /tmp/published_mirror -name '*.olean' | wc -l)
  chapters=$(sed 's/^Def_//' "$LIST" | grep -v '^$' | tr '\n' ' ')
  log="$LOGDIR/stage_fixpoint_${i}_$(date +%Y%m%d_%H%M).log"
  python3 -u debug/stage_def_mirror.py $chapters > "$log" 2>&1
  after=$(find /tmp/published_mirror -name '*.olean' | wc -l)
  built=$(grep -c 'built ' "$log")
  fails=$(grep -c 'FAIL' "$log")
  echo "pass $i: oleans $before -> $after (built=$built fail=$fails) log=$log"
  if [ "$after" -eq "$before" ]; then
    echo "fixpoint reached"
    break
  fi
done
# Report the residual: which FAILs are real (not ordering artifacts).
grep -h 'FAIL' "$LOGDIR"/stage_fixpoint_*_$(date +%Y%m%d)*.log 2>/dev/null \
  | sed 's/.*FAIL *//' | cut -d: -f1 | sort -u | tail -40
