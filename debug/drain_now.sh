#!/bin/bash
# Drain the submittable set in the platform's own dependency order.
#
# `debug/whats_uploadable.py` calls the production submission guard, so the
# lists it writes are exactly the items no guard defers.  Publishing a def
# unblocks thms (their `unpublished def import` verdict flips), and publishing a
# thm unblocks the sols that import it as a sibling -- so ONE pass is not enough
# and the loop re-derives the set every round.  Every round is bounded and the
# loop stops when a full round converts nothing (the sequencer's contract).
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
LOOPS=${LOOPS:-40}
TAG=${TAG:-drain}
LOG="state/${TAG}_$(date +%Y%m%d).log"
# Empty, not 0: round 1 has no previous round, and "(was 0)" read as "gained
# 12,914 this round" when round 1 had in fact gained nothing.
last=
for i in $(seq 1 "$LOOPS"); do
  {
    echo "=== ROUND $i $(date +%H:%M:%S)"
    python3 debug/whats_uploadable.py 2>&1 | grep -E "uploadable=|pending="
  } | tee -a "$LOG"
  for kind in def thm sol; do
    f="/tmp/uploadable_${kind}.txt"
    n=$(wc -l < "$f" 2>/dev/null || echo 0)
    [ "$n" -gt 0 ] || continue
    # Per-kind budget.  A gate-OK def whose imported theorems are not Proved can
    # only WAIT, and a WAIT does not consume the chunk's item budget, so the def
    # chunk would otherwise burn its whole 700 s every round on 4 items (§2.37-4).
    # 120 s became too small once the publish-job history grew past 12k rows:
    # the catalogue preflight alone (~90 s with the per-process memo) left no
    # time to actually POST a def, so chunks resolved 0 items two rounds in a
    # row (2026-10-16, §2.56).  420 s covers preflight + up to 5 submits+polls.
    secs=700; [ "$kind" = def ] && secs=420
    echo "--- $kind chunk ($n, max ${secs}s)" | tee -a "$LOG"
    timeout 1500 python3 pipeline/upload_pipeline.py --kind "$kind" \
      --only-file "$f" --max-items 60 --parallel 16 \
      --job-timeout 200 --max-seconds "$secs" \
      2>&1 | grep -E "DONE|FAIL|WAIT|park|chunk" | tail -70 | tee -a "$LOG"
  done
  done_now=$(python3 - <<'EOF'
import json
st=json.load(open('state/pipeline.json'))['items']
print(sum(1 for v in st.values() if v.get('status')=='done'))
EOF
)
  echo "=== ROUND $i end: done=$done_now${last:+, previous round $last}" | tee -a "$LOG"
  if [ -n "$last" ] && [ "$done_now" -eq "$last" ]; then
    echo "=== no progress in a full round, stopping" | tee -a "$LOG"
    break
  fi
  last=$done_now
done
echo "=== DRAIN DONE $(date)" | tee -a "$LOG"
