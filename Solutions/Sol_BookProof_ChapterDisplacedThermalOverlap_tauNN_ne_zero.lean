-- Generated from ChapterDisplacedThermalOverlap.lean — solution of BookProof.ChapterDisplacedThermalOverlap.tauNN_ne_zero
import Mathlib
import Definitions.Def_ChapterDisplacedThermalOverlap
import Theorems.Thm_BookProof_ChapterDisplacedThermalOverlap_tauNN_pos
open BookProof.ChapterDisplacedThermalOverlap



noncomputable section

open MeasureTheory ProbabilityTheory Real
open scoped NNReal

set_option maxHeartbeats 1000000 in
theorem solution (nbar : ℝ≥0) : tauNN nbar ≠ 0 := by

  intro h
  have := tauNN_pos nbar
  rw [h] at this
  simp at this
