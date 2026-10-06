-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsFlow_unique_solution
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_unique
import Theorems.Thm_BookProof_NavierStokesFlow_nsFlowUnitary_eq_matrixFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (psi : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
    (hy : ∀ t, HasDerivAt y ((Complex.I • nsHamiltonian d) *ᵥ y t) t) (hy0 : y 0 = psi)
    (t : ℝ) : y t = nsFlowUnitary d t *ᵥ psi :=
  `. -/
  theorem nsFlow_unique_solution (psi : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
      (hy : ∀ t, HasDerivA
