-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.tauNN_eq_thermalTemperature
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal
open BookProof.ChapterCoherentTemperature


@[simp] private theorem tauNN_coe (nbar : ℝ≥0) : ((tauNN nbar : ℝ≥0) : ℝ) = (nbar : ℝ) + 1 / 2 := by
  simp [tauNN]

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) :
    ((tauNN nbar : ℝ≥0) : ℝ)
      = BookProof.ChapterCoherentTemperature.thermalTemperature (nbar : ℝ) := by

  rw [tauNN_coe, BookProof.ChapterCoherentTemperature.thermalTemperature]
