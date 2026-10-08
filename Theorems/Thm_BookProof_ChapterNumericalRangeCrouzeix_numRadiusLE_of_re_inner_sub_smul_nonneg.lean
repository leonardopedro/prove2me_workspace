-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_of_re_inner_sub_smul_nonneg
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_of_re_inner_sub_smul_nonneg {A : E →L[ℂ] E}
    (h : ∀ z : ℂ, ‖z‖ < 1 → ∀ x : E, 0 ≤ (⟪x, x - z • A x⟫_ℂ).re) : NumRadiusLE A 1 := by sorry
