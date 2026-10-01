-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

- The flow of `A` commutes with everything `A` commutes with. -/
theorem BookProof.NavierStokesFlow.matrixFlow_commute_of_commute (A B : Matrix (Fin n) (Fin n) ℂ) (h : Commute A B)
    (t : ℝ) : Commute (matrixFlow A := by sorry
