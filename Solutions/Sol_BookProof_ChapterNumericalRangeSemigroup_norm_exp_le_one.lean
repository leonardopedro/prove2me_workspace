-- Generated from ChapterNumericalRangeSemigroup.lean — solution of BookProof.ChapterNumericalRangeSemigroup.norm_exp_le_one
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
import Theorems.Thm_BookProof_ChapterNumericalRangeSemigroup_norm_exp_le
open BookProof.ChapterNumericalRangeSemigroup



open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]

set_option maxHeartbeats 1000000 in
theorem solution {A : E →L[ℂ] E} (h : NumReLE A 0) {t : ℝ} (ht : 0 ≤ t) :
    ‖NormedSpace.exp (t • A)‖ ≤ 1 := by

  have := norm_exp_le h ht
  simpa using this
