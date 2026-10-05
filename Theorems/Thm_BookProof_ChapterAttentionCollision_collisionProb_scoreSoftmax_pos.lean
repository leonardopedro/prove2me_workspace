-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.collisionProb_scoreSoftmax_pos
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.collisionProb_scoreSoftmax_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < collisionProb (scoreSoftmax beta s) := by sorry
