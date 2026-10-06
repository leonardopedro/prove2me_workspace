-- Generated from ChapterPositiveSquareRootUnique.lean — solution of BookProof.PositiveSquareRoot.invCLM_nonneg
import Mathlib
import Definitions.Def_ChapterPositiveSquareRootUnique
import Theorems.Thm_BookProof_PositiveSquareRoot_inner_im_eq_zero
import Theorems.Thm_BookProof_PositiveSquareRoot_invCLM_mem
import Theorems.Thm_BookProof_ChapterDutchBook_Coherent_nonneg
open BookProof.PositiveSquareRoot




open BookProof.FarisLavine BookProof.EsaClosure BookProof.ClosureUniqueness
open BookProof.FriedrichsSquare BookProof.VonNeumannCore BookProof.UnboundedPolar
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (hT : IsNonnegSelfAdjoint T) : 0 ≤ invCLM hT := by

  rw [ContinuousLinearMap.nonneg_iff_isPositive, ContinuousLinearMap.isPositive_iff_complex]
  intro h
  have hmem := invCLM_mem hT h
  have hre := hT.nonneg _ hmem
  have him := inner_im_eq_zero hT hmem
  simp only at hre him
  have hsplit : (inner ℂ (invCLM hT h) h : ℂ)
      = inner ℂ (invCLM hT h) (invCLM hT h) + inner ℂ (invCLM hT h) (h - invCLM hT h) := by
    rw [← inner_add_right]; congr 1; abel
  have hxx : (inner ℂ (invCLM hT h) (invCLM hT h) : ℂ) = ((‖invCLM hT h‖ ^ 2 : ℝ) : ℂ) := by
    rw [inner_self_eq_norm_sq_to_K]; norm_cast
  rw [hsplit, hxx]
  constructor
  · apply Complex.ext
    · simp only [RCLike.re_to_complex, Complex.ofReal_re]
    · simp only [RCLike.re_to_complex, Complex.ofReal_im, Complex.add_im, him, add_zero]
  · simp only [RCLike.re_to_complex, Complex.add_re, Complex.ofReal_re]
    have hsq : (0:ℝ) ≤ ‖invCLM hT h‖ ^ 2 := by positivity
    linarith
