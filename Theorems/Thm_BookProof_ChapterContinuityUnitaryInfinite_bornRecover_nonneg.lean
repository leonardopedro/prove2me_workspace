-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_nonneg
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_nonneg (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ}
    (h : Disjoint B C) :
    bornRecover v t psi (B ∪ C) = bornRecover v t psi B + bornRecover v t psi C := by sorry
