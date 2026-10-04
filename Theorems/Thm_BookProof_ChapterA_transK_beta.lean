-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.transK_beta
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.transK_beta (β : V ≃ₗᵢ[ℝ] W) (x : V) :
    transK β (β x) = β (Complex.I • x) := by sorry
