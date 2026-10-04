-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.collisionProb_scoreSoftmax_pos
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionCollision.collisionProb_scoreSoftmax_pos (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    0 < collisionProb (scoreSoftmax beta s) := by sorry
