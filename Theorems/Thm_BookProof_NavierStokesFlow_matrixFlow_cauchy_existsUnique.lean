-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}


open scoped BigOperators Matrix Matrix.Norms.Operator


  calc y t = (matrixFlow A t * matrixFlow A (-t)) *ᵥ y t := by rw [matrixFlow_mul_neg]; simp
    _ = matrixFlow A t *ᵥ (matrixFlow A (-t) *ᵥ y t) := by rw [Matrix.mulVec_mulVec]
    _ = matrixFlow A t *ᵥ x := by rw [h0]

/-- **Global existence and uniqueness for a linear finite-dimensional Cauchy
problem.**  For every initial value there is exactly one curve, defined at every
r := by sorry
