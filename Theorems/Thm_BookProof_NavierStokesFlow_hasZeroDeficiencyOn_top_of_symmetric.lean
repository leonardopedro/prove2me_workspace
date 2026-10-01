-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_top_of_symmetric
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.hasZeroDeficiencyOn_top_of_symmetric (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiencyOn (⊤ : Submodule ℂ F) (restrictToTop H) := by sorry
