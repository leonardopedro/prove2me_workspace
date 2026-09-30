-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.applyVecCLM_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow










open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    applyVecCLM x A = A *ᵥ x := rfl
