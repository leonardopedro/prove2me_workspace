-- Generated from ChapterDiffuseCdfModel.lean — solution of BookProof.ChapterDiffuseCdfModel.exists_cdf_eq
import Mathlib
import Definitions.Def_ChapterDiffuseCdfModel
import Theorems.Thm_BookProof_ChapterDiffuseCdfModel_continuous_cdf_of_noAtoms
open BookProof.ChapterDiffuseCdfModel



noncomputable section

open MeasureTheory ProbabilityTheory Filter


variable (mu : Measure ℝ)

variable (mu : Measure ℝ)

set_option maxHeartbeats 1000000 in
theorem solution [IsProbabilityMeasure mu] [NullSingletonClass mu] {t : ℝ} (ht0 : 0 < t)
    (ht1 : t < 1) : ∃ x : ℝ, cdf mu x = t := by

  have hc : Continuous (cdf mu) := continuous_cdf_of_noAtoms mu
  obtain ⟨a, ha⟩ := ((tendsto_cdf_atBot mu).eventually (eventually_lt_nhds ht0)).exists
  obtain ⟨b, hb⟩ := ((tendsto_cdf_atTop mu).eventually (eventually_gt_nhds ht1)).exists
  rcases le_total a b with hab | hab
  · obtain ⟨x, -, hx⟩ :=
      intermediate_value_Icc hab hc.continuousOn ⟨le_of_lt ha, le_of_lt hb⟩
    exact ⟨x, hx⟩
  · obtain ⟨x, -, hx⟩ :=
      intermediate_value_Icc' hab hc.continuousOn ⟨le_of_lt ha, le_of_lt hb⟩
    exact ⟨x, hx⟩
