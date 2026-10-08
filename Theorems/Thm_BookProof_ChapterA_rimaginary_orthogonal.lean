-- Generated from ChapterA1.lean — theorem BookProof.ChapterA.rimaginary_orthogonal
import Mathlib
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

theorem BookProof.ChapterA.rimaginary_orthogonal (J : W ≃ₗᵢ[ℝ] W) (hJ : ∀ x, J (J x) = -x) (x : W) :
    inner ℝ (J x) x = 0 := by sorry
