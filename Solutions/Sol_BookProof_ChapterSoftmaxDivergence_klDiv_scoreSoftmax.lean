-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.klDiv_scoreSoftmax
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Theorems.Thm_BookProof_ChapterSoftmaxDivergence_klDiv_eq_crossEntropy_sub_shannonEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_crossEntropy_scoreSoftmax
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_shannonEntropy_scoreSoftmax
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta gamma : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    klDiv (scoreSoftmax beta s) (scoreSoftmax gamma s)
      = logPartition gamma s - logPartition beta s
          - (gamma - beta) * meanScore beta s := by

  have hq0 : ∀ j, 0 < scoreSoftmax gamma s j := fun j => scoreSoftmax_pos gamma s j
  rw [klDiv_eq_crossEntropy_sub_shannonEntropy hq0,
    crossEntropy_scoreSoftmax gamma s (scoreSoftmax_sum_one beta s i),
    shannonEntropy_scoreSoftmax beta s i, ← meanScore]
  ring
