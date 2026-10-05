-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.renyi2_scoreSoftmax_le_shannonEntropy
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_renyi2_le_shannonEntropy
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    renyi2 (scoreSoftmax beta s) ≤ shannonEntropy (scoreSoftmax beta s) := renyi2_le_shannonEntropy (scoreSoftmax_nonneg beta s) (scoreSoftmax_sum_one beta s i)
