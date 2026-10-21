-- Generated from ChapterSolovayTailDimension.lean — solution of BookProof.ChapterSolovayTailDimension.substrateInterval_measureReal_pos
import Mathlib
import Definitions.Def_ChapterSolovayTailDimension
import Theorems.Thm_BookProof_ChapterSolovayTailDimension_substrateInterval_measure
open BookProof.ChapterSolovayTailDimension



noncomputable section

open MeasureTheory Set PhysMehler PhysMeasureBasis
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    0 < unitMeasure.real (substrateInterval n) := by

  have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
  have hn2 : (0 : ℝ) < (n : ℝ) + 2 := by positivity
  have hlt : 1 / ((n : ℝ) + 2) < 1 / ((n : ℝ) + 1) := by
    apply one_div_lt_one_div_of_lt hn1; linarith
  rw [measureReal_def, substrateInterval_measure, ENNReal.toReal_ofReal (by linarith)]
  linarith
