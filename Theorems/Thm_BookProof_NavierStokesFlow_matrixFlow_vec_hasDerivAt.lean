-- Generated from ChapterNavierStokesCauchy.lean — theorem BookProof.NavierStokesFlow.matrixFlow_vec_hasDerivAt
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)


open scoped BigOperators Matrix Matrix.Norms.Operator

]
  simp [NormedSpace.exp_zero]

theorem BookProof.NavierStokesFlow.matrixFlow_vec_hasDerivAt (A : Matrix (Fin n) (Fin n) ℂ) (x : Fin n → ℂ) (t : ℝ) :
    HasDerivAt (fun s : ℝ => matrixFlow A s *ᵥ x) (A := by sorry
