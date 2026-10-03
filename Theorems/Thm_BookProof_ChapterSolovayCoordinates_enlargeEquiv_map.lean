-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.enlargeEquiv_map
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.enlargeEquiv_map (N k : ℕ) (headDist : Measure (Fin N → ℝ))
    [IsProbabilityMeasure headDist] :
    Measure.map (enlargeEquiv N k) (coordinateStateMeasure N headDist) =
      coordinateStateMeasure (N + k) (enlargedHeadMeasure N k headDist) := by sorry
