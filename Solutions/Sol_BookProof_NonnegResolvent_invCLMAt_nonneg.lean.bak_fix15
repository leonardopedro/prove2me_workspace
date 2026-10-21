-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.invCLMAt_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_inner_im_eq_zero
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) : 0 ≤ invCLMAt hT ha := by

  rw [ContinuousLinearMap.nonneg_iff_isPositive, ContinuousLinearMap.isPositive_iff_complex]
  intro h
  have hmem := invCLMAt_mem hT ha h
  have hre := hT.nonneg _ hmem
  have him := inner_im_eq_zero hT hmem
  simp only at hre him
  set x := invCLMAt hT ha h with hxdef
  have hsplit : (inner ℂ x h : ℂ)
      = inner ℂ x ((a : ℂ) • x) + inner ℂ x (h - (a : ℂ) • x) := by
    rw [← inner_add_right]; congr 1; abel
  have hxx : (inner ℂ x ((a : ℂ) • x) : ℂ) = ((a * ‖x‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_smul_right, inner_self_eq_norm_sq_to_K]
    push_cast
    rfl
  rw [hsplit, hxx]
  constructor
  · apply Complex.ext
    · simp only [RCLike.re_to_complex, Complex.ofReal_re]
    · simp only [RCLike.re_to_complex, Complex.ofReal_im, Complex.add_im, him, add_zero]
  · simp only [RCLike.re_to_complex, Complex.add_re, Complex.ofReal_re]
    have hsq : (0 : ℝ) ≤ a * ‖x‖ ^ 2 := by positivity
    linarith
