-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.inner_single_left
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.inner_single_left (phi : L2Z) (k : ℤ) (c : ℂ) :
    ⟪(lp.single 2 k c : L2Z), phi⟫_ℂ = (starRingEnd ℂ) c * (phi : ℤ → ℂ) k := by sorry
