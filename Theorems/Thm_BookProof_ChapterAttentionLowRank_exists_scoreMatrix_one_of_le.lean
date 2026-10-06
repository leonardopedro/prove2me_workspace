-- Generated from ChapterAttentionLowRank.lean — theorem BookProof.ChapterAttentionLowRank.exists_scoreMatrix_one_of_le
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank

variable {m d : ℕ}


open scoped BigOperators

noncomputable section



theorem BookProof.ChapterAttentionLowRank.exists_scoreMatrix_one_of_le (hd : m ≤ d) :
    ∃ Q K : Fin m → Fin d → ℝ, scoreMatrix Q K = 1 := by sorry
