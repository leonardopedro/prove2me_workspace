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
    ∃! y : ℝ → Fin n → ℂ, y 0 = x ∧ ∀ t, HasDerivAt y (A *ᵥ y t) t := by

  refine ⟨fun t => matrixFlow A t *ᵥ x, ⟨?_, fun t => matrixFlow_vec_hasDerivAt A x t⟩, ?_⟩
  · simp [matrixFlow, NormedSpace.exp_zero]
  · rintro y ⟨hy0, hy⟩
    exact funext fun t => matrixFlow_unique A x y hy hy0 t
