-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.collisionProb_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.collisionProb_pos {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) : 0 < collisionProb p := by sorry
