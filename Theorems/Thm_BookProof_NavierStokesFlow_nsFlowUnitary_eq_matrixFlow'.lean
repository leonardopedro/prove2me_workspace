-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow'
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow' :
    nsFlowUnitary d = matrixFlow (Complex.I • nsHamiltonian d) := by sorry
