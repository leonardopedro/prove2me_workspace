-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.matrixFlow_hasDerivAt (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    HasDerivAt (matrixFlow A) (matrixFlow A t * A) t := by sorry
