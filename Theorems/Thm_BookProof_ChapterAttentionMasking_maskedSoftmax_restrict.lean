-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_restrict
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionMasking
open BookProof.ChapterAttentionMasking


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder

variable {m : ℕ}


theorem BookProof.ChapterAttentionMasking.maskedSoftmax_restrict (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hTS : T ⊆ S) {j : Fin m} (hj : j ∈ T) :
    maskedSoftmax beta s T j
      = maskedSoftmax beta s S j / ∑ l ∈ T, maskedSoftmax beta s S l := by sorry
