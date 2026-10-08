-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.causalSoftmax_eq_conditional
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMasking


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMasking.causalSoftmax_eq_conditional (beta : ℝ) (s : Fin m → ℝ) {i j : Fin m} (hij : j ≤ i) :
    maskedSoftmax beta s (causalMask m i) j
      = scoreSoftmax beta s j / ∑ l ∈ causalMask m i, scoreSoftmax beta s l := by sorry
