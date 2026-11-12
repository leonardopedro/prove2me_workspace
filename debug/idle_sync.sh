#!/bin/bash
# Run `upload_pipeline --sync` in the drain's IDLE window (between chunk exit
# and the next chunk start, 180 s).  A sync that runs WHILE a chunk is in
# flight gets clobbered: the chunk loaded its state before the sync saved and
# overwrites the reconciled records at its next save.  The pgrep here must run
# from this script file -- inlining it in a `bash -c` string makes the wrapper's
# own command line match the pattern and the wait loop never exits.
cd "$(dirname "$0")/.." || exit 1
while pgrep -f '[u]pload_pipeline\.py' >/dev/null; do sleep 5; done
echo "idle at $(date +%H:%M:%S) -- syncing"
PROVE2ME_SKIP_LOCAL_COMPILE=1 python3 pipeline/upload_pipeline.py --sync \
    > state/scratch/idle_sync.log 2>&1
grep -E "marked" state/scratch/idle_sync.log | tail -1
python3 - <<'EOF'
import json
st = json.load(open('state/pipeline.json'))
v = st['items'].get('thm:BookProof_QgFourierElim_formValue_gauge3d_elimConfig') or {}
print('gauge3d thm after sync:', v.get('status'), '| tid:', bool(v.get('theorem_id')))
EOF
echo done > state/scratch/idle_sync.marker
