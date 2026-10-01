-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_unique_solution
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

s : ℝ => nsFlowUnitary d s *ᵥ psi)
      ((Complex.I • nsHamiltonian d) *ᵥ (nsFlowUnitary d t *ᵥ psi)) t := by
  rw [nsFlowUnitary_eq_matrixFlow']
  exact matrixFlow_vec_hasDerivAt (Complex.I • nsHamiltonian d) psi t

/-- **D.10 (headline)** *The solution is unique*: any differentiable curve
solving `ẏ(t) = i H_N y(t)` with `y(0) = ψ` is the flow orbit `t ↦ U(t) ψ := by sorry
