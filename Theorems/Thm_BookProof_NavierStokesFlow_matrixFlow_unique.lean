-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_unique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.matrixFlow_unique (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) (y : ℝ → Fin n → ℂ)
    (hy : ∀ t, HasDerivAt y (A *ᵥ y t) t) (hy0 : y 0 = x) (t : ℝ) :
    y t = matrixFlow A t *ᵥ x := by sorry
