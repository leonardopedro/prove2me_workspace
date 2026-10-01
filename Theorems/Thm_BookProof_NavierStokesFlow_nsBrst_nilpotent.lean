-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.nsBrst_nilpotent
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterGhostField
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.GhostField
open BookProof.NavierStokesFlow

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

theorem BookProof.NavierStokesFlow.nsBrst_nilpotent : nsBrstCharge d * nsBrstCharge d = 0 := by sorry
