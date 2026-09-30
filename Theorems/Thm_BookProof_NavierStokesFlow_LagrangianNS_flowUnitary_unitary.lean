-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_unitary
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)














variable (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_unitary (t : ℝ) : (L.flowUnitary t)ᴴ * L.flowUnitary t = 1 := by sorry
