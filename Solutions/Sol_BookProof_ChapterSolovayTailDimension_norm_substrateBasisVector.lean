-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.norm_substrateBasisVector
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrateInterval_measureReal_pos
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) : ‖substrateBasisVector n‖ = 1 := by

  have hpos := substrateInterval_measureReal_pos n
  have hs : 0 < Real.sqrt (unitMeasure.real (substrateInterval n)) := Real.sqrt_pos.mpr hpos
  rw [substrateBasisVector, norm_indicatorConstLp (by norm_num) (by norm_num),
    Real.norm_eq_abs, abs_of_nonneg (by positivity),
    show (1 : ℝ) / (2 : ℝ≥0∞).toReal = 1 / 2 by norm_num, ← Real.sqrt_eq_rpow]
  field_simp
