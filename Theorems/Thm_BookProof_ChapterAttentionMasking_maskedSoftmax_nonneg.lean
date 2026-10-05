-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_nonneg
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_nonneg (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (j : Fin m) :
    0 ≤ maskedSoftmax beta s S j := by sorry
