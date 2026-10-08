-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.collisionProb_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionCollision.collisionProb_nonneg (p : Fin m → ℝ) : 0 ≤ collisionProb p := by sorry
