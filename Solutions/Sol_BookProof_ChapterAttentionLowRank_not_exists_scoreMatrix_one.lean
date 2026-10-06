-- Generated from ChapterAttentionLowRank.lean — solution of BookProof.ChapterAttentionLowRank.not_exists_scoreMatrix_one
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
import Theorems.Thm_BookProof_ChapterAttentionLowRank_rank_scoreMatrix_le
open BookProof.ChapterAttentionLowRank



open scoped BigOperators

noncomputable section


variable {m d : ℕ}

variable {m d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hd : d < m) :
    ¬ ∃ Q K : Fin m → Fin d → ℝ, scoreMatrix Q K = 1 := by

  rintro ⟨Q, K, hQK⟩
  have hrank := rank_scoreMatrix_le Q K
  rw [hQK, Matrix.rank_one] at hrank
  simp only [Fintype.card_fin] at hrank
  omega
