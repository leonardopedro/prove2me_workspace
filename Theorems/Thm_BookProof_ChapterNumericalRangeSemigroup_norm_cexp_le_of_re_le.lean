-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.norm_cexp_le_of_re_le
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


theorem BookProof.ChapterNumericalRangeSemigroup.norm_cexp_le_of_re_le {ω t : ℝ} (ht : 0 ≤ t) {z : ℂ} (hz : z.re ≤ ω) :
    ‖Complex.exp ((t : ℂ) * z)‖ ≤ Real.exp (ω * t) := by sorry
