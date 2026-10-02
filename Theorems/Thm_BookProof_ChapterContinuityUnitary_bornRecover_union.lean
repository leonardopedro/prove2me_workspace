-- Generated from ChapterContinuityUnitary.lean — theorem BookProof.ChapterContinuityUnitary.bornRecover_union
import Mathlib
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary

variable {N : ℕ} [NeZero N]


open scoped BigOperators Matrix TensorProduct



theorem BookProof.ChapterContinuityUnitary.bornRecover_union (v : ZMod N → ℝ) (t : ℝ) (psi : ZMod N → ℂ)
    {B C : Finset (ZMod N)} (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by sorry
