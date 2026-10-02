-- Generated from ChapterComplexShiftCore.lean — solution of BookProof.HashimotoShiftInvert.cshiftRange_orthogonal_eq_bot
import Mathlib
import Definitions.Def_ChapterComplexShiftCore
import Theorems.Thm_BookProof_HashimotoShiftInvert_cshiftMap_apply
import Theorems.Thm_BookProof_FarisLavine_quadForm_im
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℂ} (hγ : γ.im ≠ 0) : (cshiftRange A γ)ᗮ = ⊥ := by

  rw [Submodule.eq_bot_iff]
  intro w hw
  have hip : ∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) ((starRingEnd ℂ) γ • w) := by
    intro v
    have hmem : cshiftMap A γ v ∈ cshiftRange A γ := ⟨v, rfl⟩
    have h0 : (inner ℂ (cshiftMap A γ v) w : ℂ) = 0 := hw _ hmem
    rw [cshiftMap_apply, inner_sub_left, inner_smul_left] at h0
    rw [inner_smul_right]
    linear_combination -h0
  obtain ⟨hwmem, hAw⟩ := hsa w ((starRingEnd ℂ) γ • w) hip
  have hq0 : (inner ℂ w (A ⟨w, hwmem⟩) : ℂ).im = 0 := quadForm_im A hsym ⟨w, hwmem⟩
  rw [hAw, inner_smul_right, inner_self_eq_norm_sq_to_K] at hq0
  have hq : -γ.im * ‖w‖ ^ 2 = 0 := by
    rw [Complex.mul_im, Complex.conj_re, Complex.conj_im] at hq0
    simp only [RCLike.ofReal_eq_complex_ofReal, ← Complex.ofReal_pow, Complex.ofReal_re,
      Complex.ofReal_im] at hq0
    linarith
  have hzero : ‖w‖ = 0 := by
    rcases mul_eq_zero.mp hq with h | h
    · exact absurd (by linarith : γ.im = 0) hγ
    · exact pow_eq_zero_iff (n := 2) (by norm_num) |>.mp h
  simpa using hzero
