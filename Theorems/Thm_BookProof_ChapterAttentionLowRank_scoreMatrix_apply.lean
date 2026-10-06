-- Generated from ChapterAttentionLowRank.lean — theorem BookProof.ChapterAttentionLowRank.scoreMatrix_apply
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank

variable {m d : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterAttentionLowRank.scoreMatrix_apply (Q K : Fin m → Fin d → ℝ) (i j : Fin m) :
    scoreMatrix Q K i j = ∑ a, Q i a * K j a := by sorry
