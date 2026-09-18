-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.restrictToTop_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.restrictToTop_apply (H : F →ₗ[ℂ] F) (v : (⊤ : Submodule ℂ F)) :
    (restrictToTop H v : F) = H (v : F) := by sorry
