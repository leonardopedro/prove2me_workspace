-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.attendedMass_le_one
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


theorem BookProof.ChapterAttentionSparse.attendedMass_le_one (beta : ℝ) (s : Fin m → ℝ) (S : Finset (Fin m)) (i : Fin m) :
    attendedMass beta s S ≤ 1 := by sorry
