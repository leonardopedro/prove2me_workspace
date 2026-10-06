-- Generated from PhysMeasureBasis.lean — solution of PhysMeasureBasis.null_singleton_volume
import Mathlib
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis



open MeasureTheory Set ProbabilityTheory
open scoped ENNReal

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) : volume ({y} : Set ℝ) = 0 := by

  norm_num +zetaDelta at *
