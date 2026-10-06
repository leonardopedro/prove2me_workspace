-- Generated from ChapterSoftmaxMaxEntropy.lean — solution of BookProof.ChapterSoftmaxMaxEntropy.shannonEntropy_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_log_scoreSoftmax
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterSoftmaxMaxEntropy



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (scoreSoftmax beta s) = logPartition beta s - beta * meanScore beta s := by

  have hsum : ∑ l, scoreSoftmax beta s l = 1 := scoreSoftmax_sum_one beta s i
  have hterm : ∀ l : Fin m, scoreSoftmax beta s l * Real.log (scoreSoftmax beta s l)
      = beta * (scoreSoftmax beta s l * s l) - logPartition beta s * scoreSoftmax beta s l := by
    intro l; rw [log_scoreSoftmax]; ring
  rw [shannonEntropy, Finset.sum_congr rfl fun l _ => hterm l, Finset.sum_sub_distrib,
    ← Finset.mul_sum, ← Finset.mul_sum, hsum, ← meanScore]
  ring
