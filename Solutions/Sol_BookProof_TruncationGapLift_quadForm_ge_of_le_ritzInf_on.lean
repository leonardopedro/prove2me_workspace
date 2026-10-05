-- Generated from ChapterTruncationGapLift.lean — solution of BookProof.TruncationGapLift.quadForm_ge_of_le_ritzInf_on
import Mathlib
import Definitions.Def_ChapterTruncationGapLift
import Theorems.Thm_BookProof_BandEnclosure_quadForm_real_smul
import Theorems.Thm_BookProof_HermiteGalerkin_ritzSet_bddBelow
open BookProof.TruncationGapLift



noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin BookProof.BandEnclosure
open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.YangMillsFockGapChain

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H : D →ₗ[ℂ] F)
    (hpos : ∀ x : D, 0 ≤ quadForm H x) {V : Submodule ℂ F} {mu : ℝ}
    (hmu : mu ≤ ritzInf H V) (x : D) (hx : (x : F) ∈ V) :
    mu * ‖(x : F)‖ ^ 2 ≤ quadForm H x := by

  rcases eq_or_ne ((x : F)) 0 with hx0 | hxne
  · have : x = 0 := Subtype.ext hx0
    simp [this, quadForm]
  · have hnpos : 0 < ‖(x : F)‖ := norm_pos_iff.mpr hxne
    set c : ℝ := ‖(x : F)‖⁻¹ with hc
    have hunit : ‖(((c : ℂ) • x : D) : F)‖ = 1 := by
      rw [Submodule.coe_smul, norm_smul]
      simp [hc, hnpos.ne']
    have hmemV : (((c : ℂ) • x : D) : F) ∈ V := by
      rw [Submodule.coe_smul]; exact V.smul_mem _ hx
    have hmem : quadForm H ((c : ℂ) • x) ∈ ritzSet H V :=
      ⟨(c : ℂ) • x, hmemV, hunit, rfl⟩
    have hle : ritzInf H V ≤ quadForm H ((c : ℂ) • x) :=
      csInf_le (ritzSet_bddBelow H hpos V) hmem
    rw [quadForm_real_smul] at hle
    have hsq : c ^ 2 * ‖(x : F)‖ ^ 2 = 1 := by
      rw [hc, inv_pow, inv_mul_cancel₀ (pow_ne_zero 2 hnpos.ne')]
    have h2 := mul_le_mul_of_nonneg_right (hmu.trans hle) (sq_nonneg ‖(x : F)‖)
    have h3 : c ^ 2 * quadForm H x * ‖(x : F)‖ ^ 2
        = (c ^ 2 * ‖(x : F)‖ ^ 2) * quadForm H x := by ring
    rw [h3, hsq, one_mul] at h2
    exact h2
