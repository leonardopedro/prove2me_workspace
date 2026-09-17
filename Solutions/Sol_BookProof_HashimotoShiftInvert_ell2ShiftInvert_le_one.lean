-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.ell2ShiftInvert_le_one
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_diagCLM_norm_apply_le
import Theorems.Thm_BookProof_HashimotoShiftInvert_diagCLM_symmetric
import Theorems.Thm_BookProof_HashimotoShiftInvert_sqrtInvCoeff_abs_le_one
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ShiftInvert_eq_sq
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (v : ℓ²(ℕ, ℂ)) :
    (1 : ℝ) * ‖ell2ShiftInvert v‖ ^ 2 ≤ (inner ℂ (ell2ShiftInvert v) v : ℂ).re := by

  set S := diagCLM sqrtInvCoeff_abs_le_one with hS
  have hsq : ell2ShiftInvert v = S (S v) := ell2ShiftInvert_eq_sq v
  have hinner : (inner ℂ (ell2ShiftInvert v) v : ℂ) = inner ℂ (S v) (S v) := by
    rw [hsq]
    exact diagCLM_symmetric sqrtInvCoeff_abs_le_one (S v) v
  have hre : (inner ℂ (ell2ShiftInvert v) v : ℂ).re = ‖S v‖ ^ 2 := by
    rw [hinner, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have hnorm : ‖ell2ShiftInvert v‖ ≤ ‖S v‖ := by
    rw [hsq]
    exact diagCLM_norm_apply_le sqrtInvCoeff_abs_le_one (S v)
  rw [hre, one_mul]
  nlinarith [norm_nonneg (ell2ShiftInvert v), norm_nonneg (S v)]
