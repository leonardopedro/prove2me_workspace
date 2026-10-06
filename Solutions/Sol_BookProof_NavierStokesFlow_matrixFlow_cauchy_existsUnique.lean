-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.matrixFlow_cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_vec_hasDerivAt
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_unique
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    ∃! y : ℝ → Fin n → ℂ, y 0 = x ∧ ∀ t, HasDerivAt y (A *ᵥ y t) t :=
  eal time, solving `ẏ = A y` — the flow orbit. -/
  theorem matrixFlow_cauchy_existsUnique (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
      ∃! y : ℝ → Fin n → ℂ, y 0 = x ∧ ∀ t, HasDerivAt y (A *ᵥ y t) t := by
    r
