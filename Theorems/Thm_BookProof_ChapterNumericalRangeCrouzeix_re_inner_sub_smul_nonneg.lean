-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.re_inner_sub_smul_nonneg
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.re_inner_sub_smul_nonneg {A : E →L[ℂ] E} (h : NumRadiusLE A 1) {z : ℂ}
    (hz : ‖z‖ ≤ 1) (x : E) : 0 ≤ (⟪x, x - z • A x⟫_ℂ).re := by sorry
