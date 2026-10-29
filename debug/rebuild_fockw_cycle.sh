#!/bin/bash
# Rebuild the 12 cycle-breaking Thm stub oleans + Def_ChapterFockWeightedSchurEsa
# after dropping the `import Definitions.Def_ChapterFockWeightedSchurEsa` line
# from the 12 stubs (text-level cycle FWS -> FockSchurEsa -> DegKatoEsa -> stubs
# -> FWS; the pig olean ballooned to 11+ GiB on load and OOM-killed the box).
# Every compile runs under debug/lean_watch.py (11 GiB RSS cap) so a regression
# can never reach kernel-OOM. Same lean flags as regate_bundles => comparable.
set -u
export PROVE2ME_SKIP_LOCAL_COMPILE=1
export TIMEPIECE_PROJ=/media/leo/e7ed9d6f-5f0a-4e19-a74e-83424bc154ba/timepiece331
export CANDIDATE_MIRROR=$(pwd)/state/mirror

PIGS="Thm_BookProof_DegEnergy_contDiff_cx
Thm_BookProof_DegEnergy_energy_bound
Thm_BookProof_DegEnergy_hasCompactSupport_cx
Thm_BookProof_DegEnergy_lapCS_cx_conj
Thm_BookProof_DegEnergy_norm_cx
Thm_BookProof_ConvolutionCalc_cnv_apply
Thm_BookProof_ConvolutionCalc_contDiff_cnv
Thm_BookProof_ConvolutionCalc_hasCompactSupport_dcoord
Thm_BookProof_ConvolutionCalc_hasCompactSupport_finsetSum
Thm_BookProof_ConvolutionCalc_integrable_cnv_integrand
Thm_BookProof_ConvolutionCalc_lapCS_cnv
Thm_BookProof_ConvolutionCalc_lapCS_reflect"

# 0. stage edited stub sources into the mirror (lean compiles mirror copies)
for s in $PIGS; do
  cp "Theorems/$s.lean" "state/mirror/Theorems/$s.lean" || exit 3
done
cp Definitions/Def_ChapterFockWeightedSchurEsa.lean state/mirror/Definitions/ || exit 3

# 1. rebuild stub oleans (serially, capped)
for s in $PIGS; do
  out=$(python3 debug/lean_watch.py "Theorems/$s" --cap-gb 11 --timeout 600 2>&1)
  verdict=$(echo "$out" | grep -E '^(OK|CAP|FAIL|TIMEOUT)' | head -1)
  echo "STUB $s -> $verdict"
  case "$verdict" in
    OK*) ;;
    *) echo "$out" | tail -6; echo "ABORT at $s"; exit 4;;
  esac
done

# 2. rebuild the FWS bundle olean (the pig's replacement)
out=$(python3 debug/lean_watch.py "Definitions/Def_ChapterFockWeightedSchurEsa" --cap-gb 11 --timeout 1800 2>&1)
echo "FWS -> $(echo "$out" | grep -E '^(OK|CAP|FAIL|TIMEOUT)' | head -1)"
echo "$out" | tail -5
echo "REBUILD DONE"
