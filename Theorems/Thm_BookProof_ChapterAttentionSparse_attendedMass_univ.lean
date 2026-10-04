-- Generated from ChapterAttentionSparse.lean — theorem BookProof.ChapterAttentionSparse.attendedMass_univ
import Definitions.Def_ChapterSoftmaxSharpness
import Mathlib
import Definitions.Def_ChapterAttentionSparse
import Definitions.Def_ChapterA4
open BookProof.ChapterAttentionSparse

variable {m : ℕ} {E : Type*} [NormedAddCommGroup E] [NormedSpace ℝ E]


open scoped BigOperators

noncomputable section




theorem BookProof.ChapterAttentionSparse.attendedMass_univ (beta : ℝ) (s : Fin m → ℝ) (i : Fin m) :
    attendedMass beta s Finset.univ = 1 := by sorry
