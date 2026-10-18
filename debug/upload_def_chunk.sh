#!/bin/bash
# Upload the def-gate-OK definitions that are safe to publish now (PIPELINE_PLAN
# §2.24: defs are the lever for ~1.2k def-gated sols).  Single-writer rule: this
# only starts a chunk when NO other upload_pipeline process is running, and each
# chunk is bounded (--max-items/--max-seconds) so the sequencer can reclaim the
# ledger between chunks.  A chunk that dies mid-flight leaves items pending;
# the next chunk retries them -- never worse than a wasted WAIT.
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
LIST=${LIST:-/tmp/def_upload_ok.json}
CHUNK=${CHUNK:-10}
MARK=state/def_upload_done
mkdir -p "$MARK"
i=0
while true; do
  left=$(python3 - "$LIST" "$MARK" <<'EOF'
import json, os, sys
lst=json.load(open(sys.argv[1])); mark=sys.argv[2]
done=set()
for p in os.listdir(mark):
    if p.endswith('.done'):
        done.update(l.strip() for l in open(os.path.join(mark,p)) if l.strip())
todo=[x for x in lst if x not in done]
print(len(todo))
EOF
)
  [ "$left" -eq 0 ] && { echo "DEF QUEUE EMPTY $(date)"; break; }
  # single-writer: wait for any running uploader (incl. the sol sequencer chunk)
  while pgrep -f "upload_pipeline.py" > /dev/null; do sleep 20; done
  i=$((i+1))
  chunk=$(python3 - "$LIST" "$MARK" "$CHUNK" <<'EOF'
import json, os, sys
lst=json.load(open(sys.argv[1])); mark=sys.argv[2]; n=int(sys.argv[3])
done=set()
for p in os.listdir(mark):
    if p.endswith('.done'):
        done.update(l.strip() for l in open(os.path.join(mark,p)) if l.strip())
todo=[x for x in lst if x not in done][:n]
print('\n'.join(todo))
EOF
)
  [ -z "$chunk" ] && { echo "DEF QUEUE EMPTY $(date)"; break; }
  mapfile -t chunk_arr <<< "$chunk"
  only_args=()
  for c in "${chunk_arr[@]}"; do only_args+=(--only "def:$c"); done
  echo "=== def chunk $i (${#chunk_arr[@]} defs) $(date +%H:%M:%S)"
  timeout 2400 python3 pipeline/upload_pipeline.py --kind def \
    "${only_args[@]}" --max-items "${#chunk_arr[@]}" --parallel 4 \
    --job-timeout 300 --max-seconds 2200 \
    2>&1 | grep -E "DONE|FAIL|WAIT|park|submitting|summary" | tail -40
  rc=${PIPESTATUS[0]}
  if [ "$rc" -ne 124 ]; then
    printf '%s\n' "${chunk_arr[@]}" > "$MARK/chunk_$i.done"
  else
    echo "def chunk $i timed out (rc=124) — not marked done"
    break
  fi
done
echo "DEF UPLOAD DONE $(date)"
