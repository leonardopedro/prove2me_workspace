-- Generated from ChapterA1.lean — theorem BookProof.ChapterA.rimaginary_symm_apply
import Mathlib
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]
variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

theorem BookProof.ChapterA.rimaginary_symm_apply (J : W ≃ₗᵢ[ℝ] W) (hJ : ∀ x, J (J x) = -x) (x : W) :
    J.symm x = -J x := by sorry
