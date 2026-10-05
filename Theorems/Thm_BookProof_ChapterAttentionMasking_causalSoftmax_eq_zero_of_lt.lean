-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.causalSoftmax_eq_zero_of_lt
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.causalSoftmax_eq_zero_of_lt (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : i < j) :
    maskedSoftmax beta s (causalMask m i) j = 0 := by sorry
