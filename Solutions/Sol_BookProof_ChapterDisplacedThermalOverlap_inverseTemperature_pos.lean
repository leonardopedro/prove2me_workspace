-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.inverseTemperature_pos
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) : 0 < inverseTemperature nbar := by

  rw [inverseTemperature]
  positivity
