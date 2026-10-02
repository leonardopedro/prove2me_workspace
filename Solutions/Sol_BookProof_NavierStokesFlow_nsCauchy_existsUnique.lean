-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsCauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_cauchy_existsUnique
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
y ((Complex.I • nsHamiltonian d) *ᵥ y t) t) (hy0 : y 0 = psi)
    (t : ℝ) : y t = nsFlowUnitary d t *ᵥ psi := by
  rw [nsFlowUnitary_eq_matrixFlow]
  exact matrixFlow_unique (Complex.I • nsHamiltonian d) psi y hy hy0 t

/-- **D.11 (headline)** *Global existence and uniqueness for the truncated
Navier–Stokes Cauchy problem* (`book.tex` ~4210–4216, truncation only): for
every initial state `ψ` there is **exactly one** curve `y : ℝ → ℂ^n` with
`y(0) = ψ` which solves `ẏ(t) = i H_N y(t)` at every real time, namely the
unitary orbit `t ↦ U(t) ψ`.  Existence for *all* `t` is the completeness of the
flow; by `nsFlow_noBlowup` the solution never leaves the sphere of radius
`‖ψ‖`, so the :=
  re is no finite-time singularity on the truncation. -/
  theorem nsCauchy
