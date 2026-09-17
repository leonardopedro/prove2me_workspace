-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.shiftRange_isClosed
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_norm_shiftMap_ge
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : IsClosed ((shiftRange A γ : Submodule ℂ F) : Set F) := by

  refine IsSeqClosed.isClosed ?_
  intro u p hu hup
  choose x hx using hu
  -- the preimages form a Cauchy sequence, by the shift bound
  have hcauchy : CauchySeq (fun n => ((x n : F))) := by
    have hucauchy : CauchySeq u := hup.cauchySeq
    rw [Metric.cauchySeq_iff] at hucauchy ⊢
    intro eps heps
    obtain ⟨N, hN⟩ := hucauchy (γ * eps) (by positivity)
    refine ⟨N, fun m hm n hn => ?_⟩
    have hb : γ * ‖((x m - x n : Dom) : F)‖ ≤ ‖shiftMap A γ (x m - x n)‖ :=
      norm_shiftMap_ge hpos _
    rw [map_sub, hx m, hx n] at hb
    have hlt : ‖u m - u n‖ < γ * eps := by
      have hd := hN m hm n hn
      rwa [dist_eq_norm] at hd
    have hkey : γ * ‖((x m : F)) - ((x n : F))‖ < γ * eps := by
      refine lt_of_le_of_lt ?_ hlt
      simpa using hb
    rw [dist_eq_norm]
    exact lt_of_mul_lt_mul_left hkey hγ.le
  obtain ⟨w, hw⟩ := cauchySeq_tendsto_of_complete hcauchy
  -- and their images under `A` converge too
  have hAconv : Tendsto (fun n => A (x n)) atTop (nhds (p - (γ : ℂ) • w)) := by
    have hval : ∀ n, A (x n) = u n - (γ : ℂ) • ((x n : F)) := by
      intro n
      have hn := hx n
      simp only [shiftMap_apply] at hn
      exact eq_sub_of_add_eq hn
    simp only [hval]
    exact hup.sub (hw.const_smul ((γ : ℂ)))
  obtain ⟨hwmem, hAw⟩ := closed_of_selfAdjointCriterion hsym hsa hw hAconv
  refine ⟨⟨w, hwmem⟩, ?_⟩
  simp only [shiftMap_apply, hAw]
  abel
