-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.displacedThermal_variance
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (a : ℝ) (nbar : ℝ≥0) :
    Var[id; displacedThermal a nbar] = (nbar : ℝ) + 1 / 2 := by

  simp [displacedThermal]
