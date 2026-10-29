#!/bin/bash
# Rebuild the 13 cycle-cut oleans (12 Thm stubs + Def_ChapterFarisLavine)
# after debug/cut_import_cycles.py removed their cycle-closing import lines
# and synced them into the mirror.  Each compile runs under
# debug/lean_watch.py (11 GiB RSS cap) so a regression can never reach
# kernel-OOM.  Sequential: stub closures overlap; one at a time keeps the
# box under the cap.  Log: state/scratch/rebuild_cycle_cuts.log
set -u
cd "$(dirname "$0")/.."
export PROVE2ME_SKIP_LOCAL_COMPILE=1
LOG=state/scratch/rebuild_cycle_cuts.log
: > "$LOG"
MODS="Definitions/Def_ChapterFarisLavine
Theorems/Thm_BookProof_ChapterStoneMeasurable_norm_le_of_inner_self_bound
Theorems/Thm_BookProof_ChapterH8_coordIncl_adjoint_comp
Theorems/Thm_BookProof_ChapterH8_orthonormalEmbedding_adjoint_comp
Theorems/Thm_BookProof_HermiteGalerkin_galerkinCompression_tendsto
Theorems/Thm_BookProof_NavierStokesFlow_DifferentialL2_coreOp_coe
Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_comparison_core
Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_core_le_dom
Theorems/Thm_BookProof_ScalaronFiberFL_WallPot_ham_esa
Theorems/Thm_BookProof_ScalaronFiberFL_cc_integrable
Theorems/Thm_BookProof_ScalaronFiberFL_norm_xCc_sq_le
Theorems/Thm_BookProof_QgTimeStepping_qgOuterFock_fullyDiscrete_convergence
Theorems/Thm_BookProof_QgTruncationResolvent_qgOuterFock_truncation_flow_convergence"
for m in $MODS; do
  echo "=== $m  $(date +%H:%M:%S)" >> "$LOG"
  python3 debug/lean_watch.py "$m" --cap-gb 11 --timeout 1800 2>&1 \
    | grep -E '^(OK|CAP|TIMEOUT|FAIL)|first error' >> "$LOG"
done
echo "DRIVER DONE  $(date +%H:%M:%S)" >> "$LOG"
