-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsBrst_nilpotent
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
import Theorems.Thm_BookProof_GhostField_psiDag_sq
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

variable {E : Type*} [AddCommGroup E] [Module ℂ E] {ι : Type*} [Fintype ι]
variable {n : ℕ} (L : LagrangianNS n)
variable {n : ℕ} (d : NSTruncation n)

set_option maxHeartbeats 1000000 in
theorem solution : nsBrstCharge d * nsBrstCharge d = 0 := by

  rw [nsBrstCharge, ← Matrix.mul_kronecker_mul, BookProof.GhostField.psiDag_sq,
    Matrix.kronecker_zero]
