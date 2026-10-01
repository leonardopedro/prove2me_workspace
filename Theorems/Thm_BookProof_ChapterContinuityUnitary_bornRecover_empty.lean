-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_empty
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



 ‖evolvedState v t psi z‖ ^ 2

theorem BookProof.ChapterContinuityUnitary.bornRecover_empty (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    (B : Finset (ZMod N)) : 0 ≤ bornRecover v t psi B :=
  Finset.sum_nonneg fun _ _ => by positivity

theorem bornRecover_empty (v : ZMod N → := by sorry
