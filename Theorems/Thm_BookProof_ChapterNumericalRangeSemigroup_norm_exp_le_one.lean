-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_le_one
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_le_one {A : E →L[ℂ] E} (h : NumReLE A 0) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ 1 := by sorry
