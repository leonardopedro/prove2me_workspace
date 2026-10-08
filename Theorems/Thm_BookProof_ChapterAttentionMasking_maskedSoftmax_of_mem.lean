-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_of_mem
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {j : Fin m}
    (hj : j ∈ S) :
    maskedSoftmax beta s S j = Real.exp (beta * s j) / ∑ l ∈ S, Real.exp (beta * s l) := by sorry
