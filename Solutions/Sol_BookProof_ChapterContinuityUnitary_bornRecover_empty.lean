-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.bornRecover_empty
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ) :
    bornRecover v t psi ∅ = 0 := by
 simp [bornRecover]
