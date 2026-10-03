-- Generated from ChapterContinuityUnitaryInfinite.lean — solution of BookProof.ChapterContinuityUnitaryInfinite.bornRecover_nonneg
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite



open scoped ENNReal InnerProductSpace

set_option maxHeartbeats 1000000 in
theorem solution (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C :=
   bornRecover v t psi ∅ = 0 := by
    simp [bor
