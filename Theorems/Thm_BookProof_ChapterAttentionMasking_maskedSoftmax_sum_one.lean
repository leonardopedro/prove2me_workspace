-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_sum_one
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_sum_one (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    (hS : S.Nonempty) : ∑ j, maskedSoftmax beta s S j = 1 := by sorry
