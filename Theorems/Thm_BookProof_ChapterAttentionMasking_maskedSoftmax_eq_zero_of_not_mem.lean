-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_eq_zero_of_not_mem
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_eq_zero_of_not_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∉ S) : maskedSoftmax beta s S j = 0 := by sorry
