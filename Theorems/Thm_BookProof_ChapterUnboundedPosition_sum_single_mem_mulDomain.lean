-- Generated from ChapterUnboundedPosition.lean — theorem BookProof.ChapterUnboundedPosition.sum_single_mem_mulDomain
import Mathlib
import Definitions.Def_ChapterUnboundedPosition
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterUnboundedPosition


open scoped ENNReal InnerProductSpace


open BookProof.ChapterContinuityUnitaryInfinite (L2Z)

theorem BookProof.ChapterUnboundedPosition.sum_single_mem_mulDomain (f : ℤ → ℝ) (psi : L2Z) (s : Finset ℤ) :
    (∑ i ∈ s, lp.single 2 i ((psi : ℤ → ℂ) i)) ∈ mulDomain f := by sorry
