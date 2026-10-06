-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.inner_sub_const_smul
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.inner_sub_const_smul (A : E →L[ℂ] E) (c : ℂ) (x : E) :
    (⟪ x, (A - c • (1 : E →L[ℂ] E)) x ⟫_ℂ) = ⟪ x, A x ⟫_ℂ - c * (‖x‖ ^ 2 : ℝ) := by sorry
