-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)














variable (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group (s t : ℝ) :
    L.flowUnitary (s + t) = L.flowUnitary s * L.flowUnitary t := by sorry
