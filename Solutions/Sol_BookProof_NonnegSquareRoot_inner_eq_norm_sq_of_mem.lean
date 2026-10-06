-- Generated from ChapterNonnegSquareRoot.lean — solution of BookProof.NonnegSquareRoot.inner_eq_norm_sq_of_mem
import Mathlib
import Definitions.Def_ChapterNonnegSquareRoot
import Theorems.Thm_BookProof_NonnegSquareRoot_mem_sqrtRel_iff
import Theorems.Thm_BookProof_NonnegSquareRoot_isSelfAdjoint_sqrtB
import Theorems.Thm_BookProof_NonnegSquareRoot_isSelfAdjoint_sqrtC
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtB_sqrtB_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_sqrtC_sqrtC_apply
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLM_injective
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_eq_of_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_le_one
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_nonneg
open BookProof.NonnegSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open BookProof.PositiveSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T S : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T)
    (hsv : ∀ v : F, ((0 : F), v) ∈ T → v = 0) {x z w : F} (hz : (x, z) ∈ T)
    (hw : (x, w) ∈ sqrtRel hT) : (inner ℂ x z : ℂ) = ((‖w‖ ^ 2 : ℝ) : ℂ) := by

  set h : F := x + z with hh
  have hx : invCLM hT h = x := invCLM_eq_of_mem hT (by simpa [hh] using hz)
  obtain ⟨y, hy1, hy2⟩ := mem_sqrtRel_iff.1 hw
  simp only at hy1 hy2
  have hBinj : Function.Injective (sqrtB hT) :=
    sqrtOp_injective (invCLM_nonneg hT) (invCLM_le_one hT) (invCLM_injective hT hsv)
  have hBh : sqrtB hT (sqrtB hT h) = x := by rw [sqrtB_sqrtB_apply, hx]
  have hy : y = sqrtB hT h := hBinj (by rw [hy1, hBh])
  have hwval : w = sqrtC hT (sqrtB hT h) := by rw [← hy2, hy]
  have e0 : (inner ℂ w w : ℂ)
      = inner ℂ (sqrtC hT (sqrtC hT (sqrtB hT h))) (sqrtB hT h) := by
    rw [hwval,
      inner_isSelfAdjoint_left (isSelfAdjoint_sqrtC hT) (sqrtC hT (sqrtB hT h)) (sqrtB hT h)]
  have e1 : (inner ℂ (sqrtB hT h) (sqrtB hT h) : ℂ) = inner ℂ x h := by
    rw [← hBh, inner_isSelfAdjoint_left (isSelfAdjoint_sqrtB hT) (sqrtB hT h) h]
  have e2 : (inner ℂ (invCLM hT (sqrtB hT h)) (sqrtB hT h) : ℂ) = inner ℂ x x := by
    rw [← sqrtB_sqrtB_apply, ← hBh,
      inner_isSelfAdjoint_left (isSelfAdjoint_sqrtB hT) (sqrtB hT (sqrtB hT h)) (sqrtB hT h)]
  have e3 : (inner ℂ w w : ℂ) = inner ℂ x h - inner ℂ x x := by
    rw [e0, sqrtC_sqrtC_apply, inner_sub_left, e1, e2]
  have e4 : (inner ℂ x z : ℂ) = inner ℂ x h - inner ℂ x x := by
    rw [hh, inner_add_right]; ring
  have hww : (inner ℂ w w : ℂ) = ((‖w‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]; norm_cast
  rw [e4, ← e3, hww]
