-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.nsCauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_cauchy_existsUnique
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution (psi : Fin n → ℂ) :
    ∃! y : ℝ → Fin n → ℂ,
      y 0 = psi ∧ ∀ t, HasDerivAt y ((Complex.I • nsHamiltonian d) *ᵥ y t) t :=
  re is no finite-time singularity on the truncation. -/
  theorem nsCauchy
