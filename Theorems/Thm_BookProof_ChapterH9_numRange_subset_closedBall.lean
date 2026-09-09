-- Generated from ChapterH9.lean — theorem BookProof.ChapterH9.numRange_subset_closedBall
import Mathlib
import Definitions.Def_ChapterH9
open BookProof.ChapterH9

variable {E : Type*}
  [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem BookProof.ChapterH9.numRange_subset_closedBall (X : E →L[ℂ] E) :
    numRange X ⊆ Metric.closedBall (0 : ℂ) ‖X‖ := by sorry