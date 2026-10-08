-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.shift_symm_apply
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
import Definitions.Def_ChapterContinuityUnitaryInfinite
open BookProof.ChapterContinuityUnitaryInfinite
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.shift_symm_apply {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) {z : ℂ} (hz : ω < z.re)
    (y : E) : (z • (1 : E →L[ℂ] E) - A) ((shiftEquiv h hz).symm y) = y := by sorry
