-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow'
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)


open scoped BigOperators Matrix Matrix.Norms.Operator

lex.real_smul]

theorem BookProof.NavierStokesFlow.nsFlowUnitary_eq_matrixFlow' :
    nsFlowUnitary d = matrixFlow (Complex.I • nsHamiltonian d) :=
  funext (nsFlowUnitary_eq_matrixFl := by sorry
