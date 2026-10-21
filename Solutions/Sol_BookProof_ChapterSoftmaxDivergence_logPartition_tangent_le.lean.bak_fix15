-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.logPartition_tangent_le
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Theorems.Thm_BookProof_ChapterSoftmaxDivergence_klDiv_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxDivergence_klDiv_scoreSoftmax
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_nonneg
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_pos
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    logPartition beta s + (gamma - beta) * meanScore beta s ≤ logPartition gamma s := by

  have hnn : 0 ≤ klDiv (scoreSoftmax beta s) (scoreSoftmax gamma s) :=
    klDiv_nonneg (fun j => scoreSoftmax_nonneg beta s j) (scoreSoftmax_sum_one beta s i)
      (fun j => scoreSoftmax_pos gamma s j) (le_of_eq (scoreSoftmax_sum_one gamma s i))
  rw [klDiv_scoreSoftmax beta gamma s i] at hnn
  linarith
