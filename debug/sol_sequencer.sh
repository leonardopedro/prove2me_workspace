#!/bin/bash
# Sequencer: sol uploads first, thm-unblock chunks only when the sol queue is
# dry.  Every chunk is bounded; the loop exits when a full loop converts
# nothing.  Local compile gate OFF (checkout has 105 oleans -- PIPELINE_PLAN
# §2.13 Defect 1: `lake env lean` just burns the 600 s timeout; the offline
# oracle + the pre-submit guard are the real gate).
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
LOOPS=${LOOPS:-200}
TAG=${TAG:-sq}
last_done=0
for i in $(seq 1 "$LOOPS"); do
  python3 debug/recompute_sol_lists.py
  ready=$(wc -l < /tmp/ready_sol.txt)
  thms=$(wc -l < /tmp/thm_unblock.txt)
  defs=$(wc -l < /tmp/ready_def.txt 2>/dev/null || echo 0)
  echo "=== LOOP $i ready_sol=$ready thm_unblock=$thms ready_def=$defs $(date +%H:%M:%S)"
  # DEF first when present (PIPELINE_PLAN §2.33): publishing a def flips every
  # importer's `unpublished def import` verdict, which is the top thm FAIL class.
  if [ "$defs" -gt 0 ]; then
    timeout 1500 python3 pipeline/upload_pipeline.py --kind def \
      --only-file /tmp/ready_def.txt --max-items 20 --parallel 4 \
      --job-timeout 180 --max-seconds 600 \
      2>&1 | grep -E "DONE|FAIL|WAIT|park" | tail -40
  fi
  if [ "$ready" -gt 0 ]; then
    timeout 1500 python3 pipeline/upload_pipeline.py --kind sol \
      --only-file /tmp/ready_sol.txt --max-items 40 --parallel 20 \
      --job-timeout 120 --max-seconds 1200 \
      2>&1 | grep -E "DONE|FAIL|WAIT|park" | tail -50
  fi
  if [ "$thms" -gt 0 ]; then
    timeout 1500 python3 pipeline/upload_pipeline.py --kind thm \
      --only-file /tmp/thm_unblock.txt --max-items 30 --parallel 20 \
      --job-timeout 120 --max-seconds 1200 \
      2>&1 | grep -E "DONE|FAIL|WAIT|park" | tail -50
  fi
  done_now=$(python3 - <<'EOF'
import json
st=json.load(open('state/pipeline.json'))['items']
print(sum(1 for v in st.values() if v.get('status')=='done'))
EOF
)
  echo "=== LOOP $i end: done=$done_now (was $last_done)"
  if [ "$done_now" -eq "$last_done" ] && [ "$i" -gt 1 ]; then
    echo "=== no progress in a full loop, stopping"
    break
  fi
  last_done=$done_now
done
echo "=== SEQUENCER DONE $(date)"
