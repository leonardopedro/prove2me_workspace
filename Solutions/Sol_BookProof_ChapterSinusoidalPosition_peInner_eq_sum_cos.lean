-- Generated from ChapterSinusoidalPosition.lean — solution of BookProof.ChapterSinusoidalPosition.peInner_eq_sum_cos
import Mathlib
import Definitions.Def_ChapterSinusoidalPosition
open BookProof.ChapterSinusoidalPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (w : Fin n → ℝ) (p q : ℝ) :
    peInner w p q = ∑ a, Real.cos (w a * (p - q)) := by

  refine Finset.sum_congr rfl fun a _ => ?_
  have h : w a * (p - q) = w a * p - w a * q := by ring
  rw [h, Real.cos_sub]
  simp only [sinusoidalEncode]
  ring
