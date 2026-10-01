-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    (nsNumberOp A).PosSemidef := by sorry
