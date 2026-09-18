-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.norm_resolvent_apply_le
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_norm_sub_smul_ge
import Theorems.Thm_BookProof_HermiteGalerkin_sub_resolvent_apply
open BookProof.HermiteGalerkin




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0)
    (w : F) : |z.im| * ‖resolvent T z w‖ ≤ ‖w‖ := by

  have h := norm_sub_smul_ge T hT z (resolvent T z w)
  rwa [sub_resolvent_apply T hT hz w] at h
