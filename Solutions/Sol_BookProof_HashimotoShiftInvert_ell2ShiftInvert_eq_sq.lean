-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.ell2ShiftInvert_eq_sq
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_sqrtInvCoeff_abs_le_one
open scoped lp
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (x : ℓ²(ℕ, ℂ)) :
    ell2ShiftInvert x = diagCLM sqrtInvCoeff_abs_le_one (diagCLM sqrtInvCoeff_abs_le_one x) :=
  _one x) := by
    apply lp.ext
    funext n
    rw [ell2ShiftInvert, diagCLM_apply, diagCLM_apply, diagCLM_apply, ← mul_assoc]
    congr 1
    rw [← Complex.ofReal_mul]
    norm_cast
    rw [sqrtInvCoeff, Real.mul_self_sqrt (invCoeff_po
