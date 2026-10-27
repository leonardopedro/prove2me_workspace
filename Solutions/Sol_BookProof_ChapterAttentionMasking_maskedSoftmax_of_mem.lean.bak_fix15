-- Generated from ChapterAttentionMasking.lean — solution of BookProof.ChapterAttentionMasking.maskedSoftmax_of_mem
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking



open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}

variable {m : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {j : Fin m}
    (hj : j ∈ S) :
    maskedSoftmax beta s S j = Real.exp (beta * s j) / ∑ l ∈ S, Real.exp (beta * s l) := by

  rw [maskedSoftmax, if_pos hj]
