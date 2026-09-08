-- Generated from ChapterSirkRitzSpectrum.lean — solution of BookProof.ChapterSirkRitzSpectrum.rayleighInf_mul_normSq_le
import Mathlib
import Definitions.Def_ChapterSirkRitzSpectrum
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_rayleighSet_bddBelow
import Theorems.Thm_BookProof_ChapterSirkRitzSpectrum_re_inner_real_smul
open BookProof.ChapterSirkRitzSpectrum








noncomputable section


open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open Filter Topology RCLike ContinuousLinearMap ComplexOrder Pointwise

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial F] (T : F →L[ℂ] F) (x : F) :
    rayleighInf T * ‖x‖ ^ 2 ≤ (inner ℂ x (T x) : ℂ).re := by

  rcases eq_or_ne x 0 with rfl | hx
  · simp
  · have hxpos : (0 : ℝ) < ‖x‖ := norm_pos_iff.mpr hx
    set u : F := ((‖x‖⁻¹ : ℝ) : ℂ) • x with hu
    have hunorm : ‖u‖ = 1 := by
      rw [hu, norm_smul]
      simp [hxpos.ne']
    have hmem : (inner ℂ u (T u) : ℂ).re ∈ rayleighSet T := ⟨u, hunorm, rfl⟩
    have hle : rayleighInf T ≤ (inner ℂ u (T u) : ℂ).re :=
      csInf_le (rayleighSet_bddBelow T) hmem
    have hval : (inner ℂ u (T u) : ℂ).re = ‖x‖⁻¹ ^ 2 * (inner ℂ x (T x) : ℂ).re := by
      rw [hu, re_inner_real_smul T (‖x‖⁻¹) x]
    rw [hval] at hle
    have hsq : (0 : ℝ) < ‖x‖ ^ 2 := by positivity
    have := mul_le_mul_of_nonneg_right hle (le_of_lt hsq)
    calc rayleighInf T * ‖x‖ ^ 2 ≤ ‖x‖⁻¹ ^ 2 * (inner ℂ x (T x) : ℂ).re * ‖x‖ ^ 2 := this
      _ = (inner ℂ x (T x) : ℂ).re := by
          field_simp
