-- Generated from ChapterNumericalRangeSemigroup.lean — theorem BookProof.ChapterNumericalRangeSemigroup.norm_cexp_le_of_re_le
import Mathlib
import Definitions.Def_ChapterNumericalRangeSemigroup
open BookProof.ChapterNumericalRangeSemigroup

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [CompleteSpace E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeSemigroup.norm_cexp_le_of_re_le {ω t : ℝ} (ht : 0 ≤ t) {z : ℂ} (hz : z.re ≤ ω) :
    ‖Complex.exp ((t : ℂ) * z)‖ ≤ Real.exp (ω * t) := by sorry
