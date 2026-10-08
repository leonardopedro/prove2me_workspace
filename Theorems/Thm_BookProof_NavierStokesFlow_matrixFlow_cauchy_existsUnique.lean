-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}

theorem BookProof.NavierStokesFlow.matrixFlow_cauchy_existsUnique (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    ∃! y : ℝ → Fin n → ℂ, y 0 = x ∧ ∀ t, HasDerivAt y (A *ᵥ y t) t := by sorry
