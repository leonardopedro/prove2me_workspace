-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.maskedSoftmax_sub_of_mem
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Definitions.Def_ChapterSoftmaxSharpness
open BookProof.ChapterSoftmaxSharpness
open BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionSparse.maskedSoftmax_sub_of_mem (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)}
    {j : Fin m} (hj : j ∈ S) :
    maskedSoftmax beta s S j - scoreSoftmax beta s j
      = scoreSoftmax beta s j * (1 - attendedMass beta s S) / attendedMass beta s S := by sorry
