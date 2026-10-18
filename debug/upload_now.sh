#!/bin/bash
# One-shot: upload everything currently uploadable without a rebuild.
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
python3 debug/recompute_sol_lists.py
echo "=== DEF chunk ==="
timeout 1500 python3 pipeline/upload_pipeline.py --kind def \
  --only-file /tmp/ready_def.txt --max-items 30 --parallel 4 \
  --job-timeout 180 --max-seconds 1200 2>&1 | grep -E "DONE|FAIL|WAIT|park" | tail -60
echo "=== SOL chunk (ready_sol) ==="
timeout 1500 python3 pipeline/upload_pipeline.py --kind sol \
  --only-file /tmp/ready_sol.txt --max-items 40 --parallel 20 \
  --job-timeout 120 --max-seconds 900 2>&1 | grep -E "DONE|FAIL|WAIT|park" | tail -60
echo "=== DONE $(date) ==="
