-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.mixtureMeasure_diffuse_mass
import Mathlib
import Definitions.Def_ChapterAbelianMixture
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution : mixtureMeasure (Set.Icc (0 : ℝ) 1) = 1 := by

  rw [mixtureMeasure_apply _ measurableSet_Icc]
  have h2 : ((2 : ℝ)) ∉ Set.Icc (0 : ℝ) 1 := by norm_num
  simp [Real.volume_Icc, Measure.dirac_apply' _ measurableSet_Icc, h2]
