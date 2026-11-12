#!/bin/bash
# Continuous drain: one `upload_pipeline` chunk at a time, then a pause, forever.
# A single chunk exits as soon as a pass finds nothing actionable (every
# remaining item is gated), which is exactly when a gate refresh elsewhere in
# this session is about to unblock items -- so the drain has to come back.
# Single-writer: never starts a chunk while another upload_pipeline is alive.
cd "$(dirname "$0")/.." || exit 1
LOG="state/logs/drain_loop_$(date +%m%d).log"
echo "log: $LOG"
while true; do
  if pgrep -f '[u]pload_pipeline\.py' >/dev/null 2>&1; then
    sleep 60; continue
  fi
  echo "$(date +%H:%M:%S) chunk start" >> "$LOG"
  python3 pipeline/upload_pipeline.py --kind thm --kind sol --kind def \
      --parallel 20 >> "$LOG" 2>&1
  echo "$(date +%H:%M:%S) chunk exit=$? -- sleeping 180s" >> "$LOG"
  sleep 180
done
