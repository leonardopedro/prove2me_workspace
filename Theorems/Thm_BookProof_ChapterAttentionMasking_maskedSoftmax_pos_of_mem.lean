-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_pos_of_mem
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_pos_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {j : Fin m}
    (hj : j ∈ S) : 0 < maskedSoftmax beta s S j := by sorry
