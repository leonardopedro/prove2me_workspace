-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.nsFlow_unique_solution
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow









open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)

theorem BookProof.NavierStokesFlow.nsFlow_unique_solution (psi : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
    (hy : ∀ t, HasDerivAt y ((Complex.I • nsHamiltonian d) *ᵥ y t) t) (hy0 : y 0 = psi)
    (t : ℝ) : y t = nsFlowUnitary d t *ᵥ psi := by sorry
