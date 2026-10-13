-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow'
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in

theorem solution (t : ℝ) :
    HasDerivAt (nsFlowUnitary d) (nsFlowUnitary d t * (Complex.I • nsHamiltonian d)) t := by
  rw [nsFlowUnitary_eq_matrixFlow']
  exact matrixFlow_hasDerivAt (Complex.I • nsHamiltonian d) t
