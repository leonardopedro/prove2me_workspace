-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornPMF_apply
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.bornPMF_apply (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (hpsi : ∑ z, ‖psi z‖ ^ 2 = 1) (z : ZMod N) :
    bornPMF v t psi hpsi z = ENNReal.ofReal (‖evolvedState v t psi z‖ ^ 2) := by sorry
