-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (t : ℝ) :
    nsFlowUnitary d t * nsHamiltonian d = nsHamiltonian d * nsFlowUnitary d t :=
  t) B :=
    (h.smul_left t).exp_left
  
  /-- The flow commutes with its own generator: `U(t) H_N = H_N U(t)`. -/
  theorem nsFlow_comm_hamiltonian (t : ℝ) :
      nsFlowUnitary d
