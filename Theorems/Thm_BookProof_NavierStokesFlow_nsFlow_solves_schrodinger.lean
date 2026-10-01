-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_solves_schrodinger
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesFlow
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)


open scoped BigOperators Matrix Matrix.Norms.Operator

rem nsFlow_hasDerivAt (t : ℝ) :
    HasDerivAt (nsFlowUnitary d) (nsFlowUnitary d t * (Complex.I • nsHamiltonian d)) t := by
  rw [nsFlowUnitary_eq_matrixFlow']
  exact matrixFlow_hasDerivAt (Complex.I • nsHamiltonian d) t

/-- **D.9 (headline)** *The evolved state solves the Navier–Stokes evolution
equation on the truncation*: `ψ(t) = U(t) ψ` is differentiable with
`ψ̇(t) = i H_N ψ(t)`, for every real time — the differential form of
`book.tex` ~4210–4 := by sorry
