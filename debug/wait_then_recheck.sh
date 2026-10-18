#!/bin/bash
# Wait until the published mirror has all 514 Definitions oleans (the phase
# the oracle actually needs; Theorems deps are built on demand into
# /tmp/thm_dep_olean), then drain the recheck queue.  A half-built Definitions
# phase must never be used as an oracle (§2.13: a broken mirror reads as a
# broken proof).
set -u
cd "$(dirname "$0")/.."
while true; do
  n=$(ls /tmp/published_mirror/Definitions/*.olean 2>/dev/null | wc -l)
  if [ "$n" -ge 514 ]; then
    echo "mirror Definitions complete: $n/514 $(date) — starting recheck queue"
    break
  fi
  if ! pgrep -f build_published_mirror.py > /dev/null; then
    echo "mirror build DIED at $n/514 $(date) — recheck would be unsound, not starting"
    exit 1
  fi
  sleep 60
done
exec bash debug/run_recheck_queue.sh
