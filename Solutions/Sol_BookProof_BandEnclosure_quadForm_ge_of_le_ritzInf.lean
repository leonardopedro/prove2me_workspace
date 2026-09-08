-- Generated from ChapterBandEnclosure.lean — solution of BookProof.BandEnclosure.quadForm_ge_of_le_ritzInf
import Mathlib
import Definitions.Def_ChapterBandEnclosure
import Theorems.Thm_BookProof_BandEnclosure_quadForm_real_smul
open BookProof.BandEnclosure











noncomputable section

open Filter Topology


open BookProof.FockOneParticleGap BookProof.FockSecondQuantization
open BookProof.ChapterH6 BookProof.ChapterH8















open BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit BookProof.ChapterSirkRitzSpectrum

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]













open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs
open BookProof.HashimotoShiftInvert BookProof.FriedrichsExtension
open BookProof.FriedrichsFormGap

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution {D : Submodule ℂ F} (H : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) {mu : ℝ} (hmu : mu ≤ ritzInf H D) (x : D) :
    mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x := by

  rcases eq_or_ne ((x : F)) 0 with hx | hx
  · have hx0 : x = 0 := Subtype.ext hx
    simp [hx0, quadForm]
  · have hnpos : 0 < ‖(x : F)‖ := norm_pos_iff.mpr hx
    set c : ℝ := ‖(x : F)‖⁻¹ with hc
    have hcpos : 0 < c := inv_pos.mpr hnpos
    have hunit : ‖(((c : ℂ) • x : D) : F)‖ = 1 := by
      rw [Submodule.coe_smul, norm_smul]
      simp [hc, hnpos.ne']
    have hmem : quadForm H ((c : ℂ) • x) ∈ ritzSet H D :=
      ⟨(c : ℂ) • x, ((c : ℂ) • x : D).2, hunit, rfl⟩
    have hle : ritzInf H D ≤ quadForm H ((c : ℂ) • x) :=
      csInf_le (ritzSet_bddBelow H hpos D) hmem
    rw [quadForm_real_smul] at hle
    have hsq : c ^ 2 * ‖(x : F)‖ ^ 2 = 1 := by
      rw [hc, inv_pow, inv_mul_cancel₀ (pow_ne_zero 2 hnpos.ne')]
    have h2 := mul_le_mul_of_nonneg_right (hmu.trans hle) (sq_nonneg ‖(x : F)‖)
    have h3 : c ^ 2 * quadForm H x * ‖(x : F)‖ ^ 2
        = (c ^ 2 * ‖(x : F)‖ ^ 2) * quadForm H x := by ring
    rw [h3, hsq, one_mul] at h2
    exact h2
