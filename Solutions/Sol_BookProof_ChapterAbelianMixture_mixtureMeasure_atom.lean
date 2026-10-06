-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.mixtureMeasure_atom
import Mathlib
import Definitions.Def_ChapterAbelianMixture
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : mixtureMeasure {(2 : ℝ)} = 1 := by

  rw [mixtureMeasure_apply _ (measurableSet_singleton _)]
  simp
