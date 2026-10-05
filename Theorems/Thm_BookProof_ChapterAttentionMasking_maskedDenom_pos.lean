-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedDenom_pos
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionMasking.maskedDenom_pos (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} (hS : S.Nonempty) :
    0 < ∑ l ∈ S, Real.exp (beta * s l) := by sorry
