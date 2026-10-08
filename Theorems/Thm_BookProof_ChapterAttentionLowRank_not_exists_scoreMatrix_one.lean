-- Generated from ChapterAttentionLowRank.lean — theorem BookProof.ChapterAttentionLowRank.not_exists_scoreMatrix_one
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank


open scoped BigOperators

noncomputable section


variable {m d : ℕ}


theorem BookProof.ChapterAttentionLowRank.not_exists_scoreMatrix_one (hd : d < m) :
    ¬ ∃ Q K : Fin m → Fin d → ℝ, scoreMatrix Q K = 1 := by sorry
