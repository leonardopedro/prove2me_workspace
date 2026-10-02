-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow'
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
lex.real_smul]

theorem solution :
    nsFlowUnitary d = matrixFlow (Complex.I • nsHamiltonian d) :=
  funext (nsFlowUnitary_eq_matrixFl :=
  ow d)
  
  /-- **D.8** The Navier–Stokes flow is differentiable in time:
  `d/dt U(t) = U(t) · i H_N`. -/
  th
