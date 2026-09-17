-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.shiftRange_orthogonal_eq_bot
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_shiftMap_apply
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F}
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : (shiftRange A γ)ᗮ = ⊥ := by

  rw [Submodule.eq_bot_iff]
  intro w hw
  have hip : ∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) (-(γ : ℂ) • w) := by
    intro v
    have hmem : shiftMap A γ v ∈ shiftRange A γ := ⟨v, rfl⟩
    have h0 : (inner ℂ (shiftMap A γ v) w : ℂ) = 0 := hw _ hmem
    rw [shiftMap_apply, inner_add_left, inner_smul_left, Complex.conj_ofReal] at h0
    rw [inner_smul_right]
    have hval : (inner ℂ (A v) w : ℂ) = -((γ : ℂ) * inner ℂ ((v : F)) w) := by
      linear_combination h0
    rw [hval]
    ring
  obtain ⟨hwmem, hAw⟩ := hsa w (-(γ : ℂ) • w) hip
  have hquad : quadForm A ⟨w, hwmem⟩ = -γ * ‖w‖ ^ 2 := by
    rw [quadForm, hAw, inner_smul_right, inner_self_eq_norm_sq_to_K]
    simp [← Complex.ofReal_pow]
  have h1 := hpos ⟨w, hwmem⟩
  rw [hquad] at h1
  have hzero : ‖w‖ = 0 := by
    by_contra hne
    have hpw : 0 < ‖w‖ := lt_of_le_of_ne (norm_nonneg w) (Ne.symm hne)
    have hcontr : 0 < γ * ‖w‖ ^ 2 := by positivity
    linarith
  simpa using hzero
