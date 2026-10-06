-- Generated from ChapterAbelianMixture.lean — solution of BookProof.ChapterAbelianMixture.mixtureMeasure_not_purely_atomic_on_Icc
import Mathlib
import Definitions.Def_ChapterAbelianMixture
import Theorems.Thm_BookProof_ChapterAbelianMixture_mixtureMeasure_diffuse_point
import Theorems.Thm_BookProof_ChapterAbelianMixture_mixtureMeasure_diffuse_mass
open BookProof.ChapterAbelianMixture



noncomputable section

open MeasureTheory ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    0 < mixtureMeasure (Set.Icc (0 : ℝ) 1) ∧
      ∀ x ∈ Set.Icc (0 : ℝ) 1, mixtureMeasure {x} = 0 := by

  refine ⟨?_, fun x hx => mixtureMeasure_diffuse_point hx⟩
  rw [mixtureMeasure_diffuse_mass]
  exact zero_lt_one
