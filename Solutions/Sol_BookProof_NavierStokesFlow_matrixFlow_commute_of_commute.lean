-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

set_option maxHeartbeats 1000000 in
- The flow of `A` commutes with everything `A` commutes with. -/
theorem solution (A B : Matrix (Fin n) (Fin n) ℂ) (h : Commute A B)
    (t : ℝ) : Commute (matrixFlow A :=
  t) B :=
    (h.smul_left t).exp_left
  
  /-- The flow commutes with its own generator: `U(t) H_N = H_N U(t)`. -/
  theorem nsFlow_comm_hamiltonian (t : ℝ) :
      nsFlowUnitary d
