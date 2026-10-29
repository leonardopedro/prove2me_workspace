#!/bin/bash
# Per-target capped regate driver: each target gets its own watch_tree-wrapped
# regate so a ballooning compile (CAP) kills ONLY that target, never the batch,
# and never reaches kernel-OOM (15 G box; kernel OOM killed terminals twice,
# 2026-10-28 and 2026-10-29 02:57). Gate is written only when a regate
# completes, so a killed run leaves def_gate.json untouched.
set -u
export PROVE2ME_SKIP_LOCAL_COMPILE=1
export TIMEPIECE_PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331
export CANDIDATE_MIRROR=$(pwd)/state/mirror
LIST=${1:?usage: regate_capped.sh targets.txt}
TAG=${2:-r27}
while IFS= read -r T; do
  [ -n "$T" ] || continue
  printf '%s\n' "$T" > /tmp/regate_one.txt
  echo "=== $T: $(date +%H:%M:%S)"
  python3 debug/watch_tree.py --name "${TAG}_$T" --cap-gb 11 --timeout 2100 -- \
    python3 debug/regate_bundles.py --targets-file /tmp/regate_one.txt \
    --report "state/scratch/${TAG}_$T.tsv" 2>&1 | grep -vE '^(timeline|output):'
  # keep going regardless: CAP/FAIL recorded per target
done < "$LIST"
echo "DRIVER DONE"
