-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.norm_le_two_mul_of_numRadiusLE
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.norm_le_two_mul_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) : ‖A‖ ≤ 2 * r := by sorry
