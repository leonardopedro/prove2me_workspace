-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.continuityUnitary_zero
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]
variable {X : Type*}


open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

tinuityUnitary_zero (v : ZMod N → ℝ) : continuityUnitary v 0 = 1 := by
  simp [continuityUnitary, NormedSpace.exp_zero]

/-- `U` is a one-parameter group: `U (s + t) = U s := by sorry
