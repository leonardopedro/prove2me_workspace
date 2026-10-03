-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.tailSplitEquiv_map
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.tailSplitEquiv_map (k : ℕ) :
    Measure.map (tailSplitEquiv k) coordinateTailMeasure =
      (gaussianHead k).prod coordinateTailMeasure := by sorry
