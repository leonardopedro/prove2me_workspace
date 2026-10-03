-- Generated from ChapterContinuityUnitaryInfinite.lean — theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_mono
import Mathlib
import Definitions.Def_ChapterContinuityUnitaryInfinite
import Definitions.Def_ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitary
open BookProof.ChapterContinuityUnitaryInfinite


open scoped ENNReal InnerProductSpace

r, Finset.sum_union h]

theorem BookProof.ChapterContinuityUnitaryInfinite.bornRecover_mono (v : LinfZ) (t : ℝ) (psi : L2Z) {B C : Finset ℤ} (h : B ⊆ C) :
    bornRecover v t psi B ≤ bornRecover v t psi C := by sorry
