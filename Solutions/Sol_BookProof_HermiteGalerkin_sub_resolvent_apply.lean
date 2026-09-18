-- Generated from ChapterHermiteGalerkinFriedrichs.lean — solution of BookProof.HermiteGalerkin.sub_resolvent_apply
import Mathlib
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Theorems.Thm_BookProof_HermiteGalerkin_isUnit_algebraMap_sub
open BookProof.HermiteGalerkin




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (hT : IsSelfAdjoint T) {z : ℂ} (hz : z.im ≠ 0)
    (w : F) : (algebraMap ℂ (F →L[ℂ] F) z - T) (resolvent T z w) = w := by

  have hmul : (algebraMap ℂ (F →L[ℂ] F) z - T) * resolvent T z = 1 :=
    Ring.mul_inverse_cancel _ (isUnit_algebraMap_sub T hT hz)
  calc (algebraMap ℂ (F →L[ℂ] F) z - T) (resolvent T z w)
      = ((algebraMap ℂ (F →L[ℂ] F) z - T) * resolvent T z) w := rfl
    _ = w := by rw [hmul]; rfl
