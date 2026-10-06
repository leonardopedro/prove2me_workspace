-- Generated from ChapterAttentionLowRank.lean — solution of BookProof.ChapterAttentionLowRank.scoreMatrix_eq_mul
import Mathlib
import Definitions.Def_ChapterAttentionLowRank
open BookProof.ChapterAttentionLowRank



open scoped BigOperators

noncomputable section


variable {m d : ℕ}

variable {m d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (Q K : Fin m → Fin d → ℝ) :
    scoreMatrix Q K = (Matrix.of Q) * (Matrix.of K).transpose := by

  ext i j
  simp [scoreMatrix, Matrix.mul_apply, Matrix.transpose_apply]
