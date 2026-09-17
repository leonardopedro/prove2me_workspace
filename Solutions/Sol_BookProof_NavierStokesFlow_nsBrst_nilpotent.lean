-- Generated from ChapterNavierStokesFlow.lean — solution of BookProof.NavierStokesFlow.nsBrst_nilpotent
import Mathlib
import Definitions.Def_ChapterNavierStokesFlow
open BookProof.NavierStokesFlow



open scoped BigOperators Matrix Kronecker ComplexOrder TensorProduct

set_option maxHeartbeats 1000000 in
theorem solution : nsBrstCharge d * nsBrstCharge d = 0 := by

  rw [nsBrstCharge, ← Matrix.mul_kronecker_mul, BookProof.GhostField.psiDag_sq,
    Matrix.kronecker_zero]
