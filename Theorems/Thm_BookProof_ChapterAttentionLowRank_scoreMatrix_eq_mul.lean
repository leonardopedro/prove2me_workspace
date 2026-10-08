-- Generated from ChapterAttentionLowRank.lean — theorem BookProof.ChapterAttentionLowRank.scoreMatrix_eq_mul
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank


open scoped BigOperators

noncomputable section


variable {m d : ℕ}


theorem BookProof.ChapterAttentionLowRank.scoreMatrix_eq_mul (Q K : Fin m → Fin d → ℝ) :
    scoreMatrix Q K = (Matrix.of Q) * (Matrix.of K).transpose := by sorry
