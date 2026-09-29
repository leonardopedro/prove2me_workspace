-- Generated from ChapterNavierStokesCauchy.lean — solution of BookProof.NavierStokesFlow.LagrangianNS.flowUnitary_group
import Mathlib
import Definitions.Def_ChapterNavierStokesCauchy
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.LagrangianNS










open scoped BigOperators Matrix Matrix.Norms.Operator




variable {n : ℕ}

















variable {n : ℕ} (d : NSTruncation n)














variable (L : LagrangianNS n)

set_option maxHeartbeats 1000000 in
theorem solution (s t : ℝ) :
    L.flowUnitary (s + t) = L.flowUnitary s * L.flowUnitary t := by

  have hcomm : Commute ((s : ℝ) • (Complex.I • L.hFull)) ((t : ℝ) • (Complex.I • L.hFull)) :=
    ((Commute.refl (Complex.I • L.hFull)).smul_left s).smul_right t
  rw [flowUnitary, flowUnitary, flowUnitary, matrixFlow, matrixFlow, matrixFlow, add_smul,
    Matrix.exp_add_of_commute _ _ hcomm]
