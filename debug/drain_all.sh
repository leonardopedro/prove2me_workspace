#!/bin/bash
# Drain the prove2me pipeline until it stops making progress.
#
# The three layers are mutually dependent (see PIPELINE_PLAN.md §2.4): a def
# bundle that cites a lemma imports `Theorems.Thm_<slug>` and the server refuses
# it until that theorem is Proved; a thm stub imports its own chapter's def
# bundle, so it waits for that def to be PUBLISHED; a sol stub imports sibling
# thm stubs, so it waits for those to be Proved. No single `--kind` run ever
# converges -- each pass just relabels the remaining items as "waiting on".
#
# So loop over the kinds, requeueing whatever is not done each time, until a full
# pass resolves nothing. Requeueing is what makes the passes compose: an item
# gated in pass 1 is submitted in pass 2 once its provider landed in pass 1.
#
#   ./debug/drain_all.sh [max_passes] [parallel]
#
# Logs: /tmp/drain_<kind>_<pass>.log
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_WS=$PWD
export PATH=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/.elan/bin:$PATH

MAX_PASSES="${1:-8}"
PARALLEL="${2:-10}"

requeue() {  # requeue <kind> <outfile>
  python3 - "$1" "$2" <<'PY'
import json, sys
kind, out = sys.argv[1], sys.argv[2]
w = json.load(open('pipeline/wave_upload.json'))
src = w['defs'] if kind == 'def' else w['thms']
items = json.load(open('state/pipeline.json'))['items']
todo = []
for name in src:
    it = f"{kind}:{name}"
    rec = items.get(it) or {}
    if rec.get('status') != 'done':
        items[it] = {'status': 'pending', 'attempts': 0}
        todo.append(name)
json.dump({'items': items}, open('state/pipeline.json', 'w'), indent=1)
open(out, 'w').write('\n'.join(todo) + ('\n' if todo else ''))
print(f"{kind}: {len(todo)} queued", flush=True)
PY
}

counts() {  # counts -> "def done/total thm done/total sol done/total"
  python3 - <<'PY'
import json
w = json.load(open('pipeline/wave_upload.json'))
items = json.load(open('state/pipeline.json'))['items']
parts = []
for kind, src in (('def', w['defs']), ('thm', w['thms']), ('sol', w['thms'])):
    d = sum(1 for n in src if (items.get(f"{kind}:{n}") or {}).get('status') == 'done')
    parts.append(f"{kind} {d}/{len(src)}")
print('  ' + '  '.join(parts), flush=True)
PY
}

echo "=== baseline ==="
counts

for pass in $(seq 1 "$MAX_PASSES"); do
  echo "=== pass $pass ==="
  progress=0
  for kind in def thm sol; do
    list="/tmp/drain_${kind}.txt"
    log="/tmp/drain_${kind}_${pass}.log"
    n=$(requeue "$kind" "$list" | awk '{print $2}')
    [ "$n" -eq 0 ] && { echo "  $kind: nothing queued"; continue; }
    python3 pipeline/upload_pipeline.py --kind "$kind" --only-file "$list" \
      --retry-failed --parallel "$PARALLEL" --max-items "$n" \
      --job-timeout 3000 > "$log" 2>&1
    rc=$?
    done_n=$(grep -c ': DONE' "$log")
    fail_n=$(grep -c ': FAIL' "$log")
    echo "  $kind: submitted=$(grep -c submitting "$log") DONE=$done_n FAIL=$fail_n (rc=$rc)"
    progress=$((progress + done_n))
  done
  counts
  # A pass that publishes nothing cannot unblock anything: the gate conditions
  # are unchanged, so re-running would just re-spend attempts.
  if [ "$progress" -eq 0 ]; then
    echo "=== pass $pass published nothing; stopping ==="
    break
  fi
done

echo "=== reconcile platform-held duplicates ==="
python3 debug/reconcile_duplicates.py | tail -2
counts