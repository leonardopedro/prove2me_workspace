-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.tauNN_eq_thermalTemperature
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.tauNN_eq_thermalTemperature (nbar : ℝ≥0) :
    ((tauNN nbar : ℝ≥0) : ℝ)
      = BookProof.ChapterCoherentTemperature.thermalTemperature (nbar : ℝ) := by sorry
