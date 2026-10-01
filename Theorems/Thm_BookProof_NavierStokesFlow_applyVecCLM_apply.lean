-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.applyVecCLM_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.applyVecCLM_apply (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    applyVecCLM x A = A *ᵥ x := by sorry
