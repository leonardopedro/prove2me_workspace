-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_top_of_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_top_of_symmetric (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ F) (restrictToTop H) := by sorry
