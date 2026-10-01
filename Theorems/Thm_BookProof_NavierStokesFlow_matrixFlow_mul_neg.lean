-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_mul_neg
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

 1
    <;> (first | rfl | simp)

theorem BookProof.NavierStokesFlow.matrixFlow_mul_neg (A : Matrix (Fin n) (Fin n) ℂ) (t : ℝ) :
    matrix := by sorry
