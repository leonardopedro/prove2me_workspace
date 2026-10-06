-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_iff_numRange_subset
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
import Definitions.Def_ChapterH9
open BookProof.ChapterH9
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.numRadiusLE_iff_numRange_subset [CompleteSpace E] (A : E →L[ℂ] E) {r : ℝ} :
    NumRadiusLE A r ↔ BookProof.ChapterH9.numRange A ⊆ Metric.closedBall (0 : ℂ) r := by sorry
