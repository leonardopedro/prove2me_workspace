-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.inverseTemperature_strictAnti
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution : StrictAnti inverseTemperature := by

  intro s t hst
  have hs : (0 : ℝ) < 4 * ((s : ℝ) + 1 / 2) := by positivity
  have ht : (0 : ℝ) < 4 * ((t : ℝ) + 1 / 2) := by positivity
  have hlt : (s : ℝ) < (t : ℝ) := by exact_mod_cast hst
  rw [inverseTemperature, inverseTemperature]
  apply one_div_lt_one_div_of_lt hs
  linarith
