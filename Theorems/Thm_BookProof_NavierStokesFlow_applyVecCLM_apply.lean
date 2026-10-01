-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.applyVecCLM_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow

variable {n : ℕ}


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.applyVecCLM_apply (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    applyVecCLM x A = A *ᵥ x := by sorry
