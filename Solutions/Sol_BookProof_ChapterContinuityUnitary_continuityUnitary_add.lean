-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.continuityUnitary_add
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) (s t : ℝ) :
    continuityUnitary v (s + t) = continuityUnitary v s * continuityUnitary v t := by

  have hcomm : Commute (((s : ℂ) * Complex.I) • continuityHamiltonian v)
      (((t : ℂ) * Complex.I) • continuityHamiltonian v) := by
    simp [Commute, SemiconjBy, smul_smul, mul_comm]
  have hsum : (((s + t : ℝ) : ℂ) * Complex.I) • continuityHamiltonian v
      = ((s : ℂ) * Complex.I) • continuityHamiltonian v
        + ((t : ℂ) * Complex.I) • continuityHamiltonian v := by
    rw [← add_smul]
    push_cast
    ring_nf
  rw [continuityUnitary, hsum, Matrix.exp_add_of_commute _ _ hcomm]
  rfl
