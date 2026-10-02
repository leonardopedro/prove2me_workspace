-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_vec_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_unique
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}

set_option maxHeartbeats 1000000 in

  calc y t = (matrixFlow A t * matrixFlow A (-t)) *ᵥ y t := by rw [matrixFlow_mul_neg]; simp
    _ = matrixFlow A t *ᵥ (matrixFlow A (-t) *ᵥ y t) := by rw [Matrix.mulVec_mulVec]
    _ = matrixFlow A t *ᵥ x := by rw [h0]

/-- **Global existence and uniqueness for a linear finite-dimensional Cauchy
problem.**  For every initial value there is exactly one curve, defined at every
r :=
  eal time, solving `ẏ = A y` — the flow orbit. -/
  theorem matrixFlow_cauchy_existsUnique (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
      ∃! y : ℝ → Fin n → ℂ, y 0 = x ∧ ∀ t, HasDerivAt y (A *ᵥ y t) t := by
    r
