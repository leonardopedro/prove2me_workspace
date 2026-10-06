-- Generated from ChapterAttentionLowRank.lean — solution of BookProof.ChapterAttentionLowRank.scoreMatrix_apply
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank



open scoped BigOperators

noncomputable section


variable {m d : ℕ}

variable {m d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Q K : Fin m → Fin d → ℝ) (i j : Fin m) :
    scoreMatrix Q K i j = ∑ a, Q i a * K j a := rfl
