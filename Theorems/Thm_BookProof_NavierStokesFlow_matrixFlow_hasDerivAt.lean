-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow


open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}

theorem BookProof.NavierStokesFlow.matrixFlow_hasDerivAt (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    HasDerivAt (matrixFlow A) (matrixFlow A t * A) t := by sorry
