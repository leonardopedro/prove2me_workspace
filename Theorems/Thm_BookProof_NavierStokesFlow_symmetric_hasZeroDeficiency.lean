-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.symmetric_hasZeroDeficiency
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow












open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct




variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]















variable {n : ℕ} (L : LagrangianNS n)

















variable {n : ℕ} (d : NSTruncation n)

































variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.symmetric_hasZeroDeficiency (H : F →ₗ[ℂ] F) (hsym : H.IsSymmetric) :
    HasZeroDeficiency H := by sorry
