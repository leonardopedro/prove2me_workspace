-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_empty
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.bornRecover_empty (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ) :
    bornRecover v t psi ∅ = 0 := by sorry
