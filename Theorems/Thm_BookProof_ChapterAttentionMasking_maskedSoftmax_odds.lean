-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_odds
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterA4
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMasking.maskedSoftmax_odds (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} {i j : Fin m}
    (hi : i ∈ S) (hj : j ∈ S) :
    maskedSoftmax beta s S j * scoreSoftmax beta s i
      = maskedSoftmax beta s S i * scoreSoftmax beta s j := by sorry
