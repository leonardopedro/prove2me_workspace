#!/bin/bash
# Drain the stale-definition-olean backlog in the candidate mirror, chunk by
# chunk.
#
# `sync_stale_mirror.py --limit N` refreshes at most N modules per run, so one
# long bundle cannot hold the whole backlog.  Measured 2026-11-06: 559 of 701
# def bundles were stale (343 `content`, 393 `oleans-old`), and a single bundle
# can take minutes, so the work has to span runs.
#
# Stops as soon as a chunk makes no progress: a module the compiler rejects is
# restored to its old .lean + .olean and stays stale, so a blind loop would
# retry it forever.
#
# No single-writer guard needed: the candidate mirror is only read by the gate
# tools, and the pipeline compiles in its own PROVE2ME_MIRROR tree.
#
#   CHUNK=15 BUDGET=1800 bash debug/drain_mirror.sh
cd "$(dirname "$0")/.." || exit 1
LOG="state/logs/mirror_refresh_$(date +%m%d).log"
CHUNK="${CHUNK:-15}"
BUDGET="${BUDGET:-1800}"
END=$((SECONDS + BUDGET))
echo "$(date +%H:%M:%S) start chunk=$CHUNK budget=${BUDGET}s log=$LOG" | tee -a "$LOG"
while [ $SECONDS -lt $END ]; do
  if python3 debug/sync_stale_mirror.py --check --defs-only >/dev/null 2>&1; then
    echo "$(date +%H:%M:%S) mirror consistent -- done" | tee -a "$LOG"
    exit 0
  fi
  out=$(python3 debug/sync_stale_mirror.py --defs-only --limit "$CHUNK" 2>&1)
  echo "$out" >> "$LOG"
  ok=$(sed -n 's/.*SYNC DONE ok=\([0-9]*\).*/\1/p' <<<"$out")
  echo "$(date +%H:%M:%S) chunk ok=${ok:-0}" | tee -a "$LOG"
  if [ -z "$ok" ] || [ "$ok" = "0" ]; then
    echo "$(date +%H:%M:%S) no progress -- stopping" | tee -a "$LOG"
    exit 1
  fi
done
echo "$(date +%H:%M:%S) budget reached" | tee -a "$LOG"
