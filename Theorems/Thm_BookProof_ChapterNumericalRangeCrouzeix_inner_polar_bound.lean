-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.inner_polar_bound
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix


open scoped InnerProductSpace


variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


theorem BookProof.ChapterNumericalRangeCrouzeix.inner_polar_bound {A : E →L[ℂ] E} {r : ℝ} (h : NumRadiusLE A r) (x y : E) :
    ‖(⟪A y, x⟫_ℂ)‖ ≤ r * (‖x‖ ^ 2 + ‖y‖ ^ 2) := by sorry
