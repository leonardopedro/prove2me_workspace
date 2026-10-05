-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.renyi2_le_shannonEntropy
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionCollision
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionCollision.renyi2_le_shannonEntropy {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j)
    (hsum : ∑ j, p j = 1) : renyi2 p ≤ shannonEntropy p := by sorry
