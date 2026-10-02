-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.cauchy_existsUnique
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
import Theorems.Thm_BookProof_NavierStokesFlow_matrixFlow_cauchy_existsUnique
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS



open scoped BigOperators Matrix Matrix.Norms.Operator

variable {n : ℕ}
variable {n : ℕ} (d : NSTruncation n)
variable (L : LagrangianNS n)

set_option maxHeartbeats 1000000 in
Complex.I • L.hFull)) :=
    ((Commute.refl (Complex.I • L.hFull)).smul_left s).smul_right t
  rw [flowUnitary, flowUnitary, flowUnitary, matrixFlow, matrixFlow, matrixFlow, add_smul,
    Matrix.exp_add_of_commute _ _ hcomm]

/-- **B (truncated completeness)** *The Cauchy problem of the transformed
Lagrangian operator has exactly one g :=
  lobal solution*, for every initial state
  and every real time. -
