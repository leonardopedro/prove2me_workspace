-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlow_unique_solution
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_unique
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

set_option maxHeartbeats 1000000 in
s : ℝ => nsFlowUnitary d s *ᵥ psi)
      ((Complex.I • nsHamiltonian d) *ᵥ (nsFlowUnitary d t *ᵥ psi)) t := by
  rw [nsFlowUnitary_eq_matrixFlow']
  exact matrixFlow_vec_hasDerivAt (Complex.I • nsHamiltonian d) psi t

/-- **D.10 (headline)** *The solution is unique*: any differentiable curve
solving `ẏ(t) = i H_N y(t)` with `y(0) = ψ` is the flow orbit `t ↦ U(t) ψ :=
  `. -/
  theorem nsFlow_unique_solution (psi : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
      (hy : ∀ t, HasDerivA
