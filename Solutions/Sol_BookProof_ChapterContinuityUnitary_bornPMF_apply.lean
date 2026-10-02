-- Generated from ChapterContinuityUnitary.lean — solution of BookProof.ChapterContinuityUnitary.bornPMF_apply
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary



open scoped BigOperators Matrix TensorProduct


variable {N : ℕ} [NeZero N]

variable {N : ℕ} [NeZero N]

set_option maxHeartbeats 1000000 in
theorem solution (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (hpsi : ∑ z, ‖psi z‖ ^ 2 = 1) (z : ZMod N) :
    bornPMF v t psi hpsi z = ENNReal.ofReal (‖evolvedState v t psi z‖ ^ 2) := rfl
