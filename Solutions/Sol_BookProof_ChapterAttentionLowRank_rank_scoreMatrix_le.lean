-- Generated from ChapterAttentionLowRank.lean — solution of BookProof.ChapterAttentionLowRank.rank_scoreMatrix_le
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
import Theorems.Thm_BookProof_ChapterAttentionLowRank_scoreMatrix_eq_mul
open BookProof.ChapterAttentionLowRank



open scoped BigOperators

noncomputable section


variable {m d : ℕ}

variable {m d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Q K : Fin m → Fin d → ℝ) :
    (scoreMatrix Q K).rank ≤ d := by

  rw [scoreMatrix_eq_mul]
  refine le_trans (Matrix.rank_mul_le_left _ _) ?_
  simpa using (Matrix.rank_le_width (A := (Matrix.of Q)))
