-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsBrst_adjoint
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsBrst_adjoint : (nsBrstCharge d)ᴴ = nsDivergence d ⊗ₖ BookProof.GhostField.psi := by sorry
