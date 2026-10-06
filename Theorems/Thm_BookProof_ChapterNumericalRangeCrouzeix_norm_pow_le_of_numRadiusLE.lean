-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.norm_pow_le_of_numRadiusLE
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.norm_pow_le_of_numRadiusLE {A : E →L[ℂ] E} {r : ℝ} (hr : 0 ≤ r)
    (h : NumRadiusLE A r) (n : ℕ) (hn : 0 < n) : ‖A ^ n‖ ≤ 2 * r ^ n := by sorry
