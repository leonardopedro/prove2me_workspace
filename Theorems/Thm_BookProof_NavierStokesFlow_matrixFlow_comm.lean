-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_comm
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.matrixFlow_comm (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    matrixFlow A t * A = A * matrixFlow A t := by sorry
