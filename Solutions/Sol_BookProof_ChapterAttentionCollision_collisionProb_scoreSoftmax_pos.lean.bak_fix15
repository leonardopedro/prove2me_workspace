-- Generated from ChapterAttentionCollision.lean — solution of BookProof.ChapterAttentionCollision.collisionProb_scoreSoftmax_pos
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Theorems.Thm_BookProof_ChapterAttentionCollision_collisionProb_pos
import Theorems.Thm_BookProof_ChapterSoftmaxOrder_scoreSoftmax_sum_one
open BookProof.ChapterAttentionCollision



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < collisionProb (scoreSoftmax beta s) := collisionProb_pos (scoreSoftmax_sum_one beta s i)
