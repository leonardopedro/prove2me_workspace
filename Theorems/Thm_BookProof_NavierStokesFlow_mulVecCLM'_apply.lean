-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.mulVecCLM'_apply
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

theorem BookProof.NavierStokesFlow.mulVecCLM'_apply (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) :
    mulVecCLM' A x = A *ᵥ x := by sorry
