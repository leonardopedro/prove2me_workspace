-- Generated from ChapterSoftmaxDivergence.lean — solution of BookProof.ChapterSoftmaxDivergence.klDiv_scoreSoftmax_self
import Mathlib
import Definitions.Def_ChapterSoftmaxDivergence
import Theorems.Thm_BookProof_ChapterSoftmaxDivergence_klDiv_scoreSoftmax
open BookProof.ChapterSoftmaxDivergence



open scoped BigOperators

noncomputable section


open BookProof.ChapterAttentionEntropy BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    klDiv (scoreSoftmax beta s) (scoreSoftmax beta s) = 0 := by

  rw [klDiv_scoreSoftmax beta beta s i]; ring
