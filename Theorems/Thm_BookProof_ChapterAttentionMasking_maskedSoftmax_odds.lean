-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_odds
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


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_odds (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {i j : Fin m}
    (hi : i ∈ S) (hj : j ∈ S) :
    maskedSoftmax beta s S j * scoreSoftmax beta s i
      = maskedSoftmax beta s S i * scoreSoftmax beta s j := by sorry
