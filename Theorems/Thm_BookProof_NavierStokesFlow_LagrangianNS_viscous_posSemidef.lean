-- Generated from ChapterNavierStokesFlow.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.viscous_posSemidef
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterBRSTNilpotent
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.BRSTNilpotent
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.viscous_posSemidef : L.viscous.PosSemidef := by sorry
