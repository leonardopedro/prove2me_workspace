-- Generated from ChapterSoftmaxMaxEntropy.lean — solution of BookProof.ChapterSoftmaxMaxEntropy.softmax_free_energy_eq
import Mathlib
import Definitions.Def_ChapterSoftmaxMaxEntropy
import Theorems.Thm_BookProof_ChapterSoftmaxMaxEntropy_shannonEntropy_scoreSoftmax
open BookProof.ChapterSoftmaxMaxEntropy



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    -(beta * ∑ j, scoreSoftmax beta s j * s j) - shannonEntropy (scoreSoftmax beta s)
      = -logPartition beta s := by

  rw [shannonEntropy_scoreSoftmax beta s i, ← meanScore]
  ring
