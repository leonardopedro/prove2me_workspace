-- Generated from ChapterDisplacedThermalOverlap.lean — theorem BookProof.ChapterDisplacedThermalOverlap.thermal_plus_zeroPoint_conv
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap


noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

theorem BookProof.ChapterDisplacedThermalOverlap.thermal_plus_zeroPoint_conv (nbar : ℝ≥0) :
    (gaussianReal 0 nbar) ∗ (gaussianReal 0 (1 / 2)) = gaussianReal 0 (tauNN nbar) := by sorry
