-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.inv_card_le_collisionProb
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionCollision.inv_card_le_collisionProb {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    (m : ℝ)⁻¹ ≤ collisionProb p := by sorry
