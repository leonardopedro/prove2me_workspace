-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_nonneg
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.bornRecover_nonneg (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (B : Finset (ZMod N)) : 0 ≤ bornRecover v t psi B := by sorry
