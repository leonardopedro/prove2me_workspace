-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.inv_card_le_collisionProb
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionCollision.inv_card_le_collisionProb {p : Fin m → ℝ} (hsum : ∑ j, p j = 1) :
    (m : ℝ)⁻¹ ≤ collisionProb p := by sorry
