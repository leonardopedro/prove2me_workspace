-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.transK_sq
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.transK_sq (β : V ≃ₗᵢ[ℝ] W) : (transK β) * (transK β) = -1 := by sorry
