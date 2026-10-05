-- Generated from ChapterHalfLineLimitCircle.lean — solution of BookProof.HalfLineLimitCircle.deficiencyVec_ne_zero
import Mathlib
import Definitions.Def_ChapterHalfLineLimitCircle
import Theorems.Thm_BookProof_HalfLineLimitCircle_deficiencyVec_coeFn
open BookProof.HalfLineLimitCircle




open MeasureTheory Set BookProof.FarisLavine

noncomputable section

local notation "smoothTop" => ((⊤ : ℕ∞) : WithTop ℕ∞)

set_option maxHeartbeats 1000000 in
theorem solution : deficiencyVec ≠ 0 := by

  intro h
  have hae : deficiencyFun =ᵐ[hlMeasure] (fun _ => (0:ℂ)) := by
    have h0 := deficiencyVec_coeFn
    rw [h] at h0
    filter_upwards [h0, Lp.coeFn_zero (E := ℂ) (p := 2) (μ := hlMeasure)] with x h1 h2
    rw [← h1, h2]
    rfl
  have heq : EqOn deficiencyFun (fun _ => (0:ℂ)) (Ioi (0:ℝ)) :=
    Measure.eqOn_open_of_ae_eq hae isOpen_Ioi
      deficiencyFun_contDiff.continuous.continuousOn continuousOn_const
  have := heq (mem_Ioi.mpr one_pos)
  exact Complex.exp_ne_zero _ this
