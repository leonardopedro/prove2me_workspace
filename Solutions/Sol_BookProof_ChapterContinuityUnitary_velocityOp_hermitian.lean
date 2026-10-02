-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.velocityOp_hermitian
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) : (velocityOp v)ᴴ = velocityOp v := by

  ext k j
  by_cases h : k = j <;>
    simp [velocityOp, Matrix.conjTranspose_apply, Matrix.diagonal, h, eq_comm]
