-- Generated from ChapterSoftmaxOrder.lean — solution of BookProof.ChapterSoftmaxOrder.scoreSoftmax_shift
import Mathlib
import Definitions.Def_ChapterSoftmaxOrder
open BookProof.ChapterSoftmaxOrder



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta c : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta (fun l => s l + c) j = scoreSoftmax beta s j := by

  have hexp : ∀ l, Real.exp (beta * (s l + c))
      = Real.exp (beta * c) * Real.exp (beta * s l) := by
    intro l
    rw [← Real.exp_add]
    ring_nf
  have hden : (∑ l, Real.exp (beta * (s l + c)))
      = Real.exp (beta * c) * ∑ l, Real.exp (beta * s l) := by
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun l _ => hexp l
  rw [scoreSoftmax, scoreSoftmax, hexp j, hden, mul_div_mul_left _ _ (Real.exp_ne_zero _)]
