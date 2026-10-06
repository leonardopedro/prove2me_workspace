-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.smul_invCLMAt_le_one
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
import Theorems.Thm_BookProof_NonnegSquareRoot_invCLMAt_mem
import Theorems.Thm_BookProof_PositiveSquareRoot_inner_im_eq_zero
import Theorems.Thm_BookProof_PositiveSquareRoot_symm_inner
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) (ha : 0 < a) :
    (a : ℂ) • invCLMAt hT ha ≤ 1 := by

  rw [← sub_nonneg, ContinuousLinearMap.nonneg_iff_isPositive,
    ContinuousLinearMap.isPositive_iff_complex]
  intro h
  have hmem := invCLMAt_mem hT ha h
  have hre := hT.nonneg _ hmem
  have him := inner_im_eq_zero hT hmem
  simp only at hre him
  set x := invCLMAt hT ha h with hxdef
  have happ : ((1 : F →L[ℂ] F) - (a : ℂ) • invCLMAt hT ha) h = h - (a : ℂ) • x := rfl
  have hs : (inner ℂ (h - (a : ℂ) • x) x : ℂ) = inner ℂ x (h - (a : ℂ) • x) :=
    symm_inner hT hmem hmem
  have hsplit : (inner ℂ (h - (a : ℂ) • x) h : ℂ)
      = inner ℂ (h - (a : ℂ) • x) ((a : ℂ) • x)
        + inner ℂ (h - (a : ℂ) • x) (h - (a : ℂ) • x) := by
    rw [← inner_add_right]; congr 1; abel
  have hsa : (inner ℂ (h - (a : ℂ) • x) ((a : ℂ) • x) : ℂ)
      = (a : ℂ) * inner ℂ x (h - (a : ℂ) • x) := by
    rw [inner_smul_right, hs]
  have hww : (inner ℂ (h - (a : ℂ) • x) (h - (a : ℂ) • x) : ℂ)
      = ((‖h - (a : ℂ) • x‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]; norm_cast
  rw [happ, hsplit, hsa, hww]
  constructor
  · apply Complex.ext
    · simp only [RCLike.re_to_complex, Complex.ofReal_re]
    · simp only [RCLike.re_to_complex, Complex.ofReal_im, Complex.add_im, Complex.mul_im,
        Complex.ofReal_re, Complex.ofReal_im, him, zero_mul, mul_zero, add_zero]
  · simp only [RCLike.re_to_complex, Complex.add_re, Complex.ofReal_re, Complex.mul_re,
      Complex.ofReal_im, zero_mul, sub_zero]
    have hsq : (0 : ℝ) ≤ ‖h - (a : ℂ) • x‖ ^ 2 := by positivity
    have : (0 : ℝ) ≤ a * (inner ℂ x (h - (a : ℂ) • x) : ℂ).re :=
      mul_nonneg ha.le hre
    linarith
