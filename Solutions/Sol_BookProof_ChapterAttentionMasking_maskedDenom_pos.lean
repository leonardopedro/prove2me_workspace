-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.maskedDenom_pos
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} (hS : S.Nonempty) :
    0 < ∑ l ∈ S, Real.exp (beta * s l) := by

  obtain ⟨i, hi⟩ := hS
  exact Finset.sum_pos' (fun l _ => le_of_lt (Real.exp_pos _)) ⟨i, hi, Real.exp_pos _⟩
