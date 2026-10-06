-- Generated from ChapterAttentionLowRank.lean — theorem BookProof.ChapterAttentionLowRank.rank_scoreMatrix_le
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank

variable {m d : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterAttentionLowRank.rank_scoreMatrix_le (Q K : Fin m → Fin d → ℝ) :
    (scoreMatrix Q K).rank ≤ d := by sorry
