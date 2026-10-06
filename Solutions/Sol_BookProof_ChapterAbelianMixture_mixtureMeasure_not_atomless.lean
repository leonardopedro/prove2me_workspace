-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.mixtureMeasure_not_atomless
import Mathlib
import Definitions.Def_ChapterAbelianMixture
import Theorems.Thm_BookProof_ChapterAbelianMixture_mixtureMeasure_atom
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : mixtureMeasure {(2 : ℝ)} ≠ 0 := by

  rw [mixtureMeasure_atom]; exact one_ne_zero
