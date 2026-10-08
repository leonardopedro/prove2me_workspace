-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.NavierStokesFlow.nsNumberOp_posSemidef {m : ℕ} (A : Fin m → Matrix (Fin n) (Fin n) ℂ) :
    (nsNumberOp A).PosSemidef := by sorry
