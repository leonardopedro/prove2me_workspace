-- Generated from ChapterSolovayCoordinates.lean — theorem BookProof.ChapterSolovayCoordinates.finiteCoordinateMarginal
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
import Definitions.Def_ChapterA4
open BookProof.ChapterSolovayCoordinates


open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

theorem BookProof.ChapterSolovayCoordinates.finiteCoordinateMarginal (I : Finset ℕ) :
    Measure.map I.restrict coordinateTailMeasure =
      Measure.pi (fun _ : I => standardGaussian) := by sorry
