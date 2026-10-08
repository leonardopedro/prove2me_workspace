-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)

theorem BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group (s t : ℝ) :
    L.flowUnitary (s + t) = L.flowUnitary s * L.flowUnitary t := by sorry
