-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

-- The upstream matrix lemma `matrixFlow_commute_of_commute (A B) (h)` lives
-- under the SAME dotted name as this (mismnamed) node — the generator paired
-- the matrix lemma's name with `nsFlow_comm_hamiltonian`'s statement — so it
-- cannot be imported or re-declared here.  Inline its one-line proof privately.
private theorem mfc_flow_commute (A B : Matrix (Fin n) (Fin n) ℂ)
    (h : Commute A B) (t : ℝ) : Commute (matrixFlow A t) B :=
  (h.smul_left t).exp_left

set_option maxHeartbeats 1000000 in

theorem solution (t : ℝ) :
    nsFlowUnitary d t * nsHamiltonian d = nsHamiltonian d * nsFlowUnitary d t := by
  rw [nsFlowUnitary_eq_matrixFlow]
  exact (mfc_flow_commute (Complex.I • nsHamiltonian d) (nsHamiltonian d)
    (by simp [Commute, SemiconjBy]) t).eq
