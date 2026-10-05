-- Generated from ChapterSoftmaxMaxEntropy.lean — solution of BookProof.ChapterSoftmaxMaxEntropy.log_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_partition_ne_zero
import Theorems.Thm_BookProof_ChapterSoftmaxFluctuation_scoreSoftmax_eq_div
open BookProof.ChapterSoftmaxMaxEntropy



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (j : Fin m) :
    Real.log (scoreSoftmax beta s j) = beta * s j - logPartition beta s := by

  rw [scoreSoftmax_eq_div, Real.log_div (Real.exp_ne_zero _) (partition_ne_zero beta s j),
    Real.log_exp, logPartition]
