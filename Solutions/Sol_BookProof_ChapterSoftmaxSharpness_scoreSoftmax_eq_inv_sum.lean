-- Generated from ChapterSoftmaxSharpness.lean — solution of BookProof.ChapterSoftmaxSharpness.scoreSoftmax_eq_inv_sum
import Mathlib
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn

variable {n m : ℕ}

variable {n m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    scoreSoftmax beta s j = 1 / ∑ l, Real.exp (beta * (s l - s j)) := by

  have hfac : ∑ l, Real.exp (beta * s l)
      = Real.exp (beta * s j) * ∑ l, Real.exp (beta * (s l - s j)) := by
    rw [Finset.mul_sum]
    refine Finset.sum_congr rfl fun l _ => ?_
    rw [← Real.exp_add]
    ring_nf
  rw [scoreSoftmax, hfac, mul_comm, ← div_div, div_self (Real.exp_ne_zero _)]
