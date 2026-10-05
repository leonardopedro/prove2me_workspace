-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.attendedMass_pos
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


theorem BookProof.ChapterAttentionSparse.attendedMass_pos (beta : ℝ) (s : Fin m → ℝ) {S : Finset (Fin m)} (hS : S.Nonempty) :
    0 < attendedMass beta s S := by sorry
