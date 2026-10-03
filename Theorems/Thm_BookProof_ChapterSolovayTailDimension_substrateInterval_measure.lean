-- Generated from ChapterSolovayTailDimension.lean — theorem BookProof.ChapterSolovayTailDimension.substrateInterval_measure
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Definitions.Def_PhysMeasureBasis
import Definitions.Def_ChapterA4
open PhysMeasureBasis


noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

theorem BookProof.ChapterSolovayTailDimension.substrateInterval_measure (n : ℕ) :
    unitMeasure (substrateInterval n)
      = ENNReal.ofReal (1 / ((n : ℝ) + 1) - 1 / ((n : ℝ) + 2)) := by sorry
