-- Generated from ChapterSolovayCoordinates.lean — solution of BookProof.ChapterSolovayCoordinates.finiteCoordinateMarginal
import Mathlib
import Definitions.Def_ChapterSolovayCoordinates
open BookProof.ChapterSolovayCoordinates



open MeasureTheory ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (I : Finset ℕ) :
    Measure.map I.restrict coordinateTailMeasure =
      Measure.pi (fun _ : I => standardGaussian) := by

  exact Measure.infinitePi_map_restrict (fun _ : ℕ => standardGaussian)
