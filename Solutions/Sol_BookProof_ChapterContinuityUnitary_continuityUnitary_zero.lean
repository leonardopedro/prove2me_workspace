-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.continuityUnitary_zero
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) : continuityUnitary v 0 = 1 := by

  simp [continuityUnitary, NormedSpace.exp_zero]
