-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.mixtureMeasure_diffuse_point
import Mathlib
import Definitions.Def_ChapterAbelianMixture
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : x ∈ Set.Icc (0 : ℝ) 1) :
    mixtureMeasure {x} = 0 := by

  have hx2 : x ≠ 2 := by
    rcases hx with ⟨_, hx1⟩
    intro h; rw [h] at hx1; norm_num at hx1
  have hv : MeasureTheory.volume ({x} ∩ Set.Icc (0 : ℝ) 1) = 0 :=
    measure_mono_null Set.inter_subset_left (by simp)
  rw [mixtureMeasure_apply _ (measurableSet_singleton _), hv]
  simp [Ne.symm hx2]
