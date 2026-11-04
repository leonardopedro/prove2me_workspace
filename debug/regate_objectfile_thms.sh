#!/bin/bash
# Re-run the thm gate for stubs whose recorded FAIL was `object file ... does not
# exist` -- a mirror that was still being built, not a broken statement.
#
# Measured 2026-11-03: 940 of 10,203 thm-gate entries carried that status, but the
# objects named by 872 of them exist now (the mirror was rebuilt after the gate
# pass: 559 point at Def_ChapterMixedLinearEsa.olean alone).  The drain treats any
# `FAIL ...` as a hard defer, so those statements were blocked by evidence that had
# already been invalidated.  Spot-checked: ChapterH8_coordIncl_single -> OK,
# ChapterH7_generationOperator_conjTranspose -> real parse error, so the regate
# separates the two (it is a compile, not a clearing of the old verdict).
#
# Chunked because gate_thm_ok.py writes state/thm_gate.json once, at the end: a
# chunk cut short loses only its own verdicts.  watch_tree caps each chunk so a
# ballooning stub cannot reach kernel OOM (15 G box, two OOM kills on record).
# The cap must be measured in PSS: summed VmRSS charges the shared mathlib env
# once per concurrent compile, so --metric rss at --jobs 4 read 11.9 GiB on a box
# with 6 GiB in use and killed every chunk after 5 s of compiling nothing.
set -u
export PROVE2ME_SKIP_LOCAL_COMPILE=1
export TIMEPIECE_PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331
export CANDIDATE_MIRROR=$(pwd)/state/mirror
LIST=${1:?usage: regate_objectfile_thms.sh stubs.txt [chunk]}
CHUNK=${2:-100}
JOBS=${JOBS:-6}
TAG=${TAG:-r29_of}
rm -rf "state/scratch/${TAG}_chunks" && mkdir -p "state/scratch/${TAG}_chunks"
split -l "$CHUNK" -d -a 2 "$LIST" "state/scratch/${TAG}_chunks/c"
for C in "state/scratch/${TAG}_chunks"/c*; do
  n=$(grep -c . "$C")
  echo "=== $(basename "$C") ($n stubs): $(date +%H:%M:%S)"
  python3 debug/watch_tree.py --metric pss --name "${TAG}_$(basename "$C")" \
    --cap-gb 9 --timeout 2400 -- \
    python3 debug/gate_thm_ok.py --from-file "$C" --jobs "$JOBS" 2>&1 \
    | grep -vE '^(timeline|output):'
done
echo "DRIVER DONE $(date +%H:%M:%S)"
