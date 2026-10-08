-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_le_one
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_le_one {A : E →L[ℂ] E} (h : NumReLE A 0) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ 1 := by sorry
