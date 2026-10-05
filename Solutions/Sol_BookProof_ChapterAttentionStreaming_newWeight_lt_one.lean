-- Generated from ChapterAttentionStreaming.lean — solution of BookProof.ChapterAttentionStreaming.newWeight_lt_one
import Mathlib
import Definitions.Def_ChapterAttentionStreaming
import Theorems.Thm_BookProof_ChapterAttentionStreaming_snoc_denom_pos
import Theorems.Thm_BookProof_ChapterAttentionStreaming_newWeight_eq
open BookProof.ChapterAttentionStreaming



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]

set_option maxHeartbeats 1000000 in
theorem solution (beta sn : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    newWeight beta sn s < 1 := by

  have hZ : 0 < ∑ l, Real.exp (beta * s l) :=
    Finset.sum_pos (fun _ _ => Real.exp_pos _) ⟨i, Finset.mem_univ i⟩
  rw [newWeight_eq, div_lt_one (snoc_denom_pos beta sn s)]
  linarith
