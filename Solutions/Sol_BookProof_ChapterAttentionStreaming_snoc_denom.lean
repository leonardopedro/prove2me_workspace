-- Generated from ChapterAttentionStreaming.lean — solution of BookProof.ChapterAttentionStreaming.snoc_denom
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
open BookProof.ChapterAttentionStreaming



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta sn : ℝ) (s : Fin m → ℝ) :
    ∑ l, Real.exp (beta * (Fin.snoc s sn : Fin (m + 1) → ℝ) l)
      = (∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn) := by

  rw [Fin.sum_univ_castSucc]
  simp
