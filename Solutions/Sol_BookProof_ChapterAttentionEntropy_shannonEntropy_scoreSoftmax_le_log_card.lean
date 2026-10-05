-- Generated from ChapterAttentionEntropy.lean — solution of BookProof.ChapterAttentionEntropy.shannonEntropy_scoreSoftmax_le_log_card
import Mathlib
import Definitions.Def_ChapterAttentionEntropy
import Theorems.Thm_BookProof_ChapterAttentionEntropy_shannonEntropy_le_log_card
open BookProof.ChapterAttentionEntropy



open scoped BigOperators

noncomputable section


open Filter Topology BookProof.ChapterSoftmaxBorn BookProof.ChapterSoftmaxSharpness

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    shannonEntropy (fun j => scoreSoftmax beta s j) ≤ Real.log m :=
  shannonEntropy_le_log_card (fun j => scoreSoftmax_nonneg beta s j)
      (scoreSoftmax_sum_one beta s i)
