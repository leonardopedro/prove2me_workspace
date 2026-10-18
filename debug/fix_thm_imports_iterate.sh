#!/bin/bash
# Alternate `fix_thm_import_defs.py` and `regate_bundles.py` until the repaired
# set stops growing.
#
# One round of the fixer adds the imports named by ONE compiler error per bundle,
# so a bundle citing five foreign theorems needs five rounds: each `Unknown
# identifier` the compiler reports is the NEXT missing import, not the last one.
# Measured 2026-10-12: round 1 turned 9 of 26 bundles OK and exposed a second
# missing import in 14 of the 17 still failing.
#
# Bounded (ROUNDS, default 8) and it stops on the first round that turns nothing
# OK -- the same contract as `drain_now.sh`, so a wrong disambiguation cannot
# spin.  `--report` per round lands in /tmp so each step is auditable.
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
ROUNDS=${ROUNDS:-8}
CLASSIFIED=${CLASSIFIED:-/tmp/rootfail_classified.tsv}
REPORT=${REPORT:-/tmp/regate_iter}

prev_ok=0
prev_fail=-1
for i in $(seq 1 "$ROUNDS"); do
  echo "=== ROUND $i $(date +%H:%M:%S)"
  python3 debug/fix_thm_import_defs.py --classified "$CLASSIFIED" --apply \
    2>&1 | tail -3
  added=$(python3 debug/fix_thm_import_defs.py --classified "$CLASSIFIED" 2>&1 \
          | grep -c "WOULD-ADD" || true)
  awk -F'\t' '$3=="thm-stub"{print $1}' "$CLASSIFIED" > /tmp/iter_targets.txt
  n=$(wc -l < /tmp/iter_targets.txt)
  [ "$n" -gt 0 ] || { echo "no thm-stub targets left"; break; }
  python3 -u debug/regate_bundles.py --targets-file /tmp/iter_targets.txt \
    --jobs 4 --report "${REPORT}_$i.tsv" 2>&1 | tail -2
  ok=$(awk -F'\t' '$1=="OK"' "${REPORT}_$i.tsv" | wc -l)
  echo "round $i: $n target(s), $ok OK"
  # A bundle that is OK is done; re-classify only the ones still failing.
  awk -F'\t' '$1!="OK"{print $1}' "${REPORT}_$i.tsv" > /tmp/iter_fail.txt
  [ -s /tmp/iter_fail.txt ] || { echo "=== all targets OK"; break; }
  # Re-classify the remaining FAILs (same TSV shape: status \t chapter).
  python3 debug/classify_rootfail_defs.py /tmp/iter_fail.txt >/dev/null 2>&1
  # `classify_rootfail_defs.py` writes `chapter\tline\tclass\tident\tnote` while the
  # regate report is `status\tchapter`, so the join key is column 2 of the report
  # against column 1 of the classified file.  Joining column 1 to column 1 matched
  # `FAIL Definitions/Def_X.lean:77:6: ...` against `ChapterX`, never hit, and made
  # the loop report "still failing: 0" and stop after round 1 with 7 bundles left.
  awk -F'\t' 'NR==FNR{bad[$2]=1; next} ($1 in bad)' /tmp/iter_fail.txt \
    "$CLASSIFIED" > "${CLASSIFIED}.new" && mv "${CLASSIFIED}.new" "$CLASSIFIED"
  left=$(wc -l < "$CLASSIFIED")
  echo "  still failing: $left"
  [ "$left" -gt 0 ] || break
  # Stop when a round stopped turning bundles OK.  Compare the FAILING count,
  # not the OK count: each round is given a different target set (only the ones
  # still failing), so `ok` is not comparable across rounds.
  if [ "$left" -ge "$prev_fail" ] && [ "$prev_fail" -ge 0 ]; then
    echo "=== failing count did not drop ($prev_fail -> $left), stopping"
    break
  fi
  prev_fail=$left
done
echo "=== ITERATION DONE $(date)"
