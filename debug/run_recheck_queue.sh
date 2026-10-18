#!/bin/bash
# Drain state/recheck_queue.txt through the offline oracle in ~40-item chunks
# (PIPELINE_PLAN §2.24-5: wide --only sweeps hang; chunks of ~40 with an
# external timeout are the only reliable shape).  Single-writer rule: this is
# the ONLY check_pending_offline process allowed at a time.
#
# Each chunk becomes .done only when the tool exits non-timeout, so a killed
# chunk re-runs instead of silently losing slugs (§2.29-7 hardening).
set -u
cd "$(dirname "$0")/.."
Q=state/recheck_queue.txt
D=state/recheck_done
mkdir -p "$D"
CHUNK=${CHUNK:-40}
i=0
while true; do
  mapfile -t todo < <(comm -23 <(sort -u "$Q") <(cat "$D"/*.done 2>/dev/null | sort -u))
  [ ${#todo[@]} -eq 0 ] && { echo "QUEUE EMPTY $(date)"; break; }
  i=$((i+1))
  chunk=("${todo[@]:0:$CHUNK}")
  only_args=()
  for s in "${chunk[@]}"; do only_args+=(--only "$s"); done
  echo "=== recheck chunk $i (${#chunk[@]} slugs) $(date +%H:%M:%S)"
  timeout 1200 python3 debug/check_pending_offline.py --kind sol --jobs 2 \
    "${only_args[@]}" \
    2>&1 | tail -5
  rc=${PIPESTATUS[0]}
  if [ "$rc" -ne 124 ]; then
    printf '%s\n' "${chunk[@]}" > "$D/chunk_$i.done"
  else
    echo "chunk $i timed out (rc=124) — not marked done, will re-run"
    break
  fi
done
echo "RECHECK QUEUE DONE $(date)"
# Re-arm any still-failed item whose fresh verdict is now ok: the sequencer's
# recompute only looks at `pending`, so a `failed` record would never upload
# even after its file was repaired and re-verified.
python3 - <<'PYEOF'
import json, subprocess, sys
verds = json.load(open('state/offline_pending_check.json'))['sol']['items']
st = json.load(open('state/pipeline.json'))['items']
fix = [k[4:] for k, v in st.items()
       if k.startswith('sol:') and v.get('status') == 'failed'
       and verds.get(k[4:]) == 'ok']
if fix:
    print('re-arming (scoped, bounded):', fix)
    subprocess.run([sys.executable, 'pipeline/upload_pipeline.py', '--kind', 'sol',
                    '--retry-failed', '--max-items', '10', '--parallel', '4',
                    '--job-timeout', '120', '--max-seconds', '600']
                   + sum((['--only', s] for s in fix), []))
else:
    print('no failed sols with a fresh ok verdict')
PYEOF
