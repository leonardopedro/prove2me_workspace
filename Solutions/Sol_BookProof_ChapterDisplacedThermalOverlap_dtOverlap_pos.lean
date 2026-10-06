-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.dtOverlap_pos
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_dtOverlap_eq
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) (a b : ℝ) : 0 < dtOverlap nbar a b := by

  rw [dtOverlap_eq]
  have : (0 : ℝ) < (nbar : ℝ) + 1 / 2 := by positivity
  positivity
