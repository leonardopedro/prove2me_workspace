-- Generated from ChapterSoftmaxJacobian.lean — solution of BookProof.ChapterSoftmaxJacobian.weightedVar_eq_sum_sq
import Mathlib
import Definitions.Def_ChapterSoftmaxJacobian
open BookProof.ChapterSoftmaxJacobian



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s x : Fin m → ℝ) (i : Fin m) :
    weightedVar beta s x
      = ∑ j, scoreSoftmax beta s j * (x j - ∑ l, scoreSoftmax beta s l * x l) ^ 2 := by

  have hsum : ∑ j, scoreSoftmax beta s j = 1 := scoreSoftmax_sum_one beta s i
  set mu := ∑ l, scoreSoftmax beta s l * x l with hmu
  have hexp : ∀ j : Fin m, scoreSoftmax beta s j * (x j - mu) ^ 2
      = scoreSoftmax beta s j * x j ^ 2 - 2 * mu * (scoreSoftmax beta s j * x j)
        + mu ^ 2 * scoreSoftmax beta s j := fun j => by ring
  rw [weightedVar, Finset.sum_congr rfl fun j _ => hexp j, Finset.sum_add_distrib,
    Finset.sum_sub_distrib, ← Finset.mul_sum, ← Finset.mul_sum, hsum, ← hmu]
  ring
