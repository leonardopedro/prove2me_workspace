-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.tensorIsom_tmul
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]
variable {X : Type*}

set_option maxHeartbeats 1000000 in
theorem solution (X Z : Type*) [Fintype Z] [DecidableEq Z]
    (f : X → ℂ) (g : Z → ℂ) :
    tensorIsom X Z (f ⊗ₜ g) = fun p => f p.1 * g p.2 := by

  funext p
  simp [tensorIsom, swapCurry, mul_comm]
