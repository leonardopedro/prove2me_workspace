-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_commute_of_commute
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in

theorem solution (t : ℝ) :
    nsFlowUnitary d t * nsHamiltonian d = nsHamiltonian d * nsFlowUnitary d t := by
  rw [nsFlowUnitary_eq_matrixFlow]
  exact (matrixFlow_commute_of_commute (Complex.I • nsHamiltonian d) (nsHamiltonian d)
    (by simp [Commute, SemiconjBy]) t).eq
