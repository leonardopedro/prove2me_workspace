-- Generated from ChapterAttentionStreaming.lean — solution of BookProof.ChapterAttentionStreaming.one_sub_newWeight_eq
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Theorems.Thm_BookProof_ChapterAttentionStreaming_newWeight_eq
open BookProof.ChapterAttentionStreaming



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta sn : ℝ) (s : Fin m → ℝ) :
    1 - newWeight beta sn s
      = (∑ l, Real.exp (beta * s l))
          / ((∑ l, Real.exp (beta * s l)) + Real.exp (beta * sn)) := by

  rw [newWeight_eq]
  field_simp
  ring
