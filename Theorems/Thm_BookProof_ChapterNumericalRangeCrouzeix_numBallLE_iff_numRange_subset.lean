-- Generated from ChapterNumericalRangeCrouzeix.lean — theorem BookProof.ChapterNumericalRangeCrouzeix.numBallLE_iff_numRange_subset
import Mathlib
import Definitions.Def_ChapterNumericalRangeCrouzeix
import Definitions.Def_ChapterH9
open BookProof.ChapterH9
open BookProof.ChapterNumericalRangeCrouzeix

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped InnerProductSpace



theorem BookProof.ChapterNumericalRangeCrouzeix.numBallLE_iff_numRange_subset [CompleteSpace E] (A : E →L[ℂ] E) (c : ℂ) {r : ℝ} :
    NumBallLE A c r ↔ BookProof.ChapterH9.numRange A ⊆ Metric.closedBall c r := by sorry
