-- Generated from ChapterAttentionCollision.lean — theorem BookProof.ChapterAttentionCollision.one_le_effectiveSupport
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionCollision
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionCollision

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionCollision.one_le_effectiveSupport {p : Fin m → ℝ} (hp0 : ∀ j, 0 ≤ p j) (hp1 : ∀ j, p j ≤ 1)
    (hsum : ∑ j, p j = 1) : 1 ≤ effectiveSupport p := by sorry
