-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.continuityHamiltonian_hermitian
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
import Theorems.Thm_BookProof_ChapterContinuityUnitary_momentum_hermitian
import Theorems.Thm_BookProof_ChapterContinuityUnitary_velocityOp_hermitian
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) :
    (continuityHamiltonian v)ᴴ = continuityHamiltonian v := by

  have hp := momentum_hermitian (N := N)
  have hv := velocityOp_hermitian v
  simp only [continuityHamiltonian, Matrix.conjTranspose_smul, Matrix.conjTranspose_add,
    Matrix.conjTranspose_mul, hp, hv]
  rw [add_comm (velocityOp v * momentum N)]
  norm_num
