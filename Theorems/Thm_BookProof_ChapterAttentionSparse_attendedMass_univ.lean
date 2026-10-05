-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.attendedMass_univ
import Definitions.Def_ChapterSoftmaxSharpness
import Definitions.Def_ChapterSoftmaxOrder
import Mathlib
import Definitions.Def_ChapterAttentionSparse
open BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section


open BookProof.ChapterSoftmaxSharpness BookProof.ChapterSoftmaxOrder


theorem BookProof.ChapterAttentionSparse.attendedMass_univ (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attendedMass beta s Finset.univ = 1 := by sorry
