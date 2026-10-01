-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.cshiftRange_isClosed
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Theorems.Thm_BookProof_HashimotoShiftInvert_closed_of_selfAdjointCriterion
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_cshiftMap_ge
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℂ} (hγ : γ.im ≠ 0) : IsClosed ((cshiftRange A γ : Submodule ℂ F) : Set F) := by

  have hpos : 0 < |γ.im| := abs_pos.mpr hγ
  refine IsSeqClosed.isClosed ?_
  intro u p hu hup
  choose x hx using hu
  have hcauchy : CauchySeq (fun n => ((x n : F))) := by
    have hucauchy : CauchySeq u := hup.cauchySeq
    rw [Metric.cauchySeq_iff] at hucauchy ⊢
    intro eps heps
    obtain ⟨N, hN⟩ := hucauchy (|γ.im| * eps) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have hb : |γ.im| * ‖((x m - x n : Dom) : F)‖ ≤ ‖cshiftMap A γ (x m - x n)‖ :=
      norm_cshiftMap_ge hsym _ _
    rw [map_sub, hx m, hx n] at hb
    have hlt : ‖u m - u n‖ < |γ.im| * eps := by
      have hd := hN m hm n hn
      rwa [dist_eq_norm] at hd
    have hkey : |γ.im| * ‖((x m : F)) - ((x n : F))‖ < |γ.im| * eps := by
      refine lt_of_le_of_lt ?_ hlt
      simpa using hb
    rw [dist_eq_norm]
    exact lt_of_mul_lt_mul_left hkey hpos.le
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
  have hAconv : Tendsto (fun n => A (x n)) atTop (nhds (γ • w - p)) := by
    have hval : ∀ n, A (x n) = γ • ((x n : F)) - u n := by
      intro n
      have hn := hx n
      simp only [cshiftMap_apply] at hn
      rw [← hn]; abel
    simp only [hval]
    exact (hw.const_smul γ).sub hup
  obtain ⟨hwmem, hAw⟩ := closed_of_selfAdjointCriterion hsym hsa hw hAconv
  refine ⟨⟨w, hwmem⟩, ?_⟩
  simp only [cshiftMap_apply, hAw]
  abel
