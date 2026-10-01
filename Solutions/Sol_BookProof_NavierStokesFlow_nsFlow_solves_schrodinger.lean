-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlow_solves_schrodinger
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_vec_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow'
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

set_option maxHeartbeats 1000000 in
rem nsFlow_hasDerivAt (t : ℝ) :
    HasDerivAt (nsFlowUnitary d) (nsFlowUnitary d t * (Complex.I • nsHamiltonian d)) t := by
  rw [nsFlowUnitary_eq_matrixFlow']
  exact matrixFlow_hasDerivAt (Complex.I • nsHamiltonian d) t

/-- **D.9 (headline)** *The evolved state solves the Navier–Stokes evolution
equation on the truncation*: `ψ(t) = U(t) ψ` is differentiable with
`ψ̇(t) = i H_N ψ(t)`, for every real time — the differential form of
`book.tex` ~4210–4 :=
  216, on the truncation. -/
  theorem nsFlow_solves_schrodinger (psi : Fin n → ℂ) (t : ℝ) :
      HasDerivAt (fu
