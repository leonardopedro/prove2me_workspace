-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

the flow of the generator `i H_N`. -/
theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow (t : ℝ) :
    nsFlowUnitary d t = matrixFlow (Complex.I • nsHamiltonian d) t := by
  rw [ns := by sorry
