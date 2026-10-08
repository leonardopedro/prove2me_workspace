-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_apply_le
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.norm_exp_apply_le {A : E →L[ℂ] E} {ω : ℝ} (h : NumReLE A ω) (x : E) {t : ℝ}
    (ht : 0 ≤ t) : ‖NormedSpace.exp (t • A) x‖ ≤ Real.exp (ω * t) * ‖x‖ := by sorry
