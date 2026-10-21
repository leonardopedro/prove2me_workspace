-- Generated from ChapterNonnegResolvent.lean — solution of BookProof.NonnegResolvent.smul_nonneg_of_nonneg
import Mathlib
import Definitions.Def_ChapterNonnegResolvent
open BookProof.NonnegResolvent




open BookProof.ClosureUniqueness BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot
open scoped ComplexOrder

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)} {a b : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {c : ℝ} (hc : 0 ≤ c) {A : F →L[ℂ] F} (hA : 0 ≤ A) :
    0 ≤ (c : ℂ) • A := by

  rw [ContinuousLinearMap.nonneg_iff_isPositive, ContinuousLinearMap.isPositive_iff_complex] at hA
  rw [ContinuousLinearMap.nonneg_iff_isPositive, ContinuousLinearMap.isPositive_iff_complex]
  intro h
  have happ : ((c : ℂ) • A) h = (c : ℂ) • (A h) := rfl
  rw [happ, inner_smul_left, Complex.conj_ofReal]
  obtain ⟨hc1, hc2⟩ := hA h
  have him : (inner ℂ (A h) h : ℂ).im = 0 := by
    have := congrArg Complex.im hc1
    simpa using this.symm
  constructor
  · apply Complex.ext
    · simp only [RCLike.re_to_complex, Complex.ofReal_re]
    · simp only [RCLike.re_to_complex, Complex.ofReal_im, Complex.mul_im, Complex.ofReal_re,
        Complex.ofReal_im, him, mul_zero, zero_mul, add_zero]
  · simp only [RCLike.re_to_complex, Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im,
      zero_mul, sub_zero]
    exact mul_nonneg hc hc2
