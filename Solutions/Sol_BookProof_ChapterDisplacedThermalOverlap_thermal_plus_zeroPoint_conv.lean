-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.thermal_plus_zeroPoint_conv
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) :
    (gaussianReal 0 nbar) ∗ (gaussianReal 0 (1 / 2)) = gaussianReal 0 (tauNN nbar) := by

  rw [gaussianReal_conv_gaussianReal]
  simp [tauNN]
