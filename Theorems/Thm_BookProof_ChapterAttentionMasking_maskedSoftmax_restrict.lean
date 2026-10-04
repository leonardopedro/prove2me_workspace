-- Generated from ChapterAttentionMasking.lean — theorem BookProof.ChapterAttentionMasking.maskedSoftmax_restrict
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionMasking
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionMasking

variable {m : ℕ}


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionMasking.maskedSoftmax_restrict (beta : ℝ) (s : Fin m → ℝ) {S T : Finset (Fin m)}
    (hTS : T ⊆ S) {j : Fin m} (hj : j ∈ T) :
    maskedSoftmax beta s T j
      = maskedSoftmax beta s S j / ∑ l ∈ T, maskedSoftmax beta s S l := by sorry
