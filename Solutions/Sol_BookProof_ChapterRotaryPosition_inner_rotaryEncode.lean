-- Generated from ChapterRotaryPosition.lean — solution of BookProof.ChapterRotaryPosition.inner_rotaryEncode
import Mathlib
import Definitions.Def_ChapterRotaryPosition
open BookProof.ChapterRotaryPosition



open scoped BigOperators

noncomputable section


open BookProof.ChapterCoherentOverlapComplex

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (omega : Fin n → ℝ) (a b : ℝ) (q k : EuclideanSpace ℂ (Fin n)) :
    (inner ℂ (rotaryEncode omega a q) (rotaryEncode omega b k) : ℂ)
      = inner ℂ q (rotaryEncode omega (b - a) k) := by

  rw [PiLp.inner_apply, PiLp.inner_apply]
  refine Finset.sum_congr rfl fun i _ => ?_
  have hconj : (starRingEnd ℂ) (Complex.exp ((a * omega i : ℝ) * Complex.I))
      = Complex.exp (-((a * omega i : ℝ) * Complex.I)) := by
    rw [← Complex.exp_conj]
    congr 1
    simp
  have hexp : Complex.exp (-((a * omega i : ℝ) * Complex.I))
      * Complex.exp ((b * omega i : ℝ) * Complex.I)
      = Complex.exp (((b - a) * omega i : ℝ) * Complex.I) := by
    rw [← Complex.exp_add]
    congr 1
    push_cast
    ring
  simp only [RCLike.inner_apply, rotaryEncode_apply, map_mul, hconj]
  linear_combination ((starRingEnd ℂ) (q i) * k i) * hexp
