-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.numReLE_iff_numRange_subset
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
import Definitions.Def_ChapterH9
open BookProof.ChapterH9
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.numReLE_iff_numRange_subset (A : E →L[ℂ] E) {ω : ℝ} :
    NumReLE A ω ↔ BookProof.ChapterH9.numRange A ⊆ {z : ℂ | z.re ≤ ω} := by sorry
