-- Generated from ChapterSoftmaxMaxEntropy.lean — solution of BookProof.ChapterSoftmaxMaxEntropy.crossEntropy_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_log_scoreSoftmax
open BookProof.ChapterSoftmaxMaxEntropy



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {p : Fin m → ℝ}
    (hpsum : ∑ j, p j = 1) :
    crossEntropy p (scoreSoftmax beta s) = logPartition beta s - beta * ∑ j, p j * s j := by

  have hterm : ∀ j : Fin m, p j * Real.log (scoreSoftmax beta s j)
      = beta * (p j * s j) - logPartition beta s * p j := by
    intro j; rw [log_scoreSoftmax]; ring
  rw [crossEntropy, Finset.sum_congr rfl fun j _ => hterm j, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, hpsum]
  ring
