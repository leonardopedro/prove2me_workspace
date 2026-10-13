#!/usr/bin/env bash
# Drain the sols whose OWN target theorem is already published.
#
# `whats_uploadable.py` reports sols the submission guard does not defer, but
# the guard does not check the sol's OWN thm ledger status -- the WAIT
# (`theorem not published yet`) is raised later, inside the submit loop, so a
# guard-"uploadable" sol chunk can be 100% WAIT (drain53: 152 WAIT, 0 done).
# This list is derived from the ledger directly (sol pending + thm:done with
# theorem_id + local file), which is exactly the set the preflight can pass.
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
LIST=${LIST:-/tmp/real_uploadable_sol.txt}
export LIST
LOOPS=${LOOPS:-4}
TAG=${TAG:-drain_sol}
LOG="state/${TAG}_$(date +%Y%m%d).log"
# A sol with NO cached offline verdict is submitted BLIND: the guard has
# nothing to defer on, the platform answers CE, and one of the 5 attempts is
# gone.  Measured 2026-10-12 (drain55 round 1): 10 of 11 CEs had
# `offline_verdict = NONE`.  So re-derive the list every round from a FRESH
# cached `ok` instead of trusting a stale file.  This is the sol-side twin of
# the §2.40 stamp rule.
last=
for i in $(seq 1 "$LOOPS"); do
  python3 - <<'PYEOF' || exit 1
import json, os
off = json.load(open('state/offline_pending_check.json')).get('sol', {}).get('items', {})
stamp = os.path.getmtime('state/offline_pending_check.json')
names = [l.strip() for l in open(os.environ.get('LIST', '/tmp/real_uploadable_sol.txt')) if l.strip()]
keep = [n for n in names if off.get(n) == 'ok'
        and os.path.exists(f'Solutions/Sol_{n}.lean')
        and os.path.getmtime(f'Solutions/Sol_{n}.lean') <= stamp]
open('/tmp/drain_sol_verified.txt', 'w').write('\n'.join(keep) + ('\n' if keep else ''))
print(f'  verified-ok subset: {len(keep)} / {len(names)}', flush=True)
PYEOF
  LIST=/tmp/drain_sol_verified.txt
  export LIST
  [ -s "$LIST" ] || { echo "=== no verified-ok sols left, stopping" | tee -a "$LOG"; break; }
  echo "=== ROUND $i $(date +%H:%M:%S) ($(wc -l < "$LIST") item(s))" | tee -a "$LOG"
  timeout 1500 python3 pipeline/upload_pipeline.py --kind sol --only-file "$LIST" \
    --max-items 80 --parallel 16 --job-timeout 200 --max-seconds 700 \
    2>&1 | grep -E "DONE|FAIL|WAIT|park|chunk" | tail -70 | tee -a "$LOG"
  done_now=$(python3 - <<'EOF'
import json
st = json.load(open('state/pipeline.json'))['items']
print(sum(1 for v in st.values() if v.get('status') == 'done'))
EOF
)
  echo "=== ROUND $i end: done=$done_now${last:+, previous $last}" | tee -a "$LOG"
  if [ "$done_now" = "$last" ] && [ "$i" -gt 1 ]; then
    echo "=== no progress in a full round, stopping" | tee -a "$LOG"
    break
  fi
  last=$done_now
done
echo "=== DRAIN DONE $(date)" | tee -a "$LOG"
