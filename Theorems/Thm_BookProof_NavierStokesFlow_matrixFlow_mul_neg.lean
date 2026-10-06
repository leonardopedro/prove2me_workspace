-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_mul_neg
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.matrixFlow_mul_neg (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    matrixFlow A t * matrixFlow A (-t) = 1 := by sorry
