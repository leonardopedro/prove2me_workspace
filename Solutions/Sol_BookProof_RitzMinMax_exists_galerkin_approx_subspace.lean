-- Generated from ChapterSirkRitzMinMax.lean — solution of BookProof.RitzMinMax.exists_galerkin_approx_subspace
import Mathlib
import Definitions.Def_ChapterSirkRitzMinMax
import Theorems.Thm_BookProof_RitzMinMax_rayleighVal_sub_le
import Theorems.Thm_BookProof_RitzMinMax_rayleighSetOn_nonempty
import Theorems.Thm_BookProof_RitzMinMax_rayleighVal_le_rayleighSup
import Theorems.Thm_BookProof_RitzMinMax_exists_uniform_proj_bound
import Definitions.Def_ChapterSirkRitzSpectrum
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
open BookProof.RitzMinMax










noncomputable section


open BookProof.HermiteGalerkin BookProof.ChapterSirkRitzSpectrum
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T : F →L[ℂ] F) (b : HilbertBasis ℕ ℂ F)
    {S : Submodule ℂ F} {k : ℕ} (hrank : Module.finrank ℂ S = k + 1) {ε : ℝ} (hε : 0 < ε) :
    ∃ m₀ : ℕ, ∀ m ≥ m₀, ∃ S' : Submodule ℂ F, S' ≤ galerkinSpan b m ∧
      Module.finrank ℂ S' = k + 1 ∧ rayleighSup T S' ≤ rayleighSup T S + ε := by

  classical
  have hfd : FiniteDimensional ℂ S := .of_finrank_pos (by rw [hrank]; omega)
  set c : ℝ := ‖T‖ with hc
  have hc0 : 0 ≤ c := norm_nonneg _
  set δ : ℝ := min (1 / 2) (ε / (8 * c + 8)) with hδ
  have hδpos : 0 < δ := lt_min (by norm_num) (by positivity)
  have hδhalf : δ ≤ 1 / 2 := min_le_left _ _
  have hδeps : 8 * c * δ ≤ ε := by
    have h1 : δ ≤ ε / (8 * c + 8) := min_le_right _ _
    have h2 : (0 : ℝ) < 8 * c + 8 := by linarith
    calc 8 * c * δ ≤ 8 * c * (ε / (8 * c + 8)) :=
          mul_le_mul_of_nonneg_left h1 (by linarith)
      _ ≤ ε := by
          rw [mul_div_assoc', div_le_iff₀ h2]
          nlinarith [hε.le]
  obtain ⟨m₀, hm₀⟩ := exists_uniform_proj_bound b S hδpos
  refine ⟨m₀, fun m hm => ?_⟩
  set P := (galerkinSpan b m).starProjection with hP
  have hbnd : ∀ x ∈ S, ‖P x - x‖ ≤ δ * ‖x‖ := hm₀ m hm
  have hinj : Function.Injective ((P : F →ₗ[ℂ] F) ∘ₗ S.subtype) := by
    rw [← LinearMap.ker_eq_bot, LinearMap.ker_eq_bot']
    rintro ⟨x, hx⟩ hzero
    have h0 : P x = 0 := by simpa using hzero
    have h2 := hbnd x hx
    rw [h0, zero_sub, norm_neg] at h2
    have hx0 : ‖x‖ = 0 := by nlinarith [norm_nonneg x]
    ext
    simpa using hx0
  have hrk : Module.finrank ℂ (S.map (P : F →ₗ[ℂ] F)) = k + 1 := by
    have hr : LinearMap.range ((P : F →ₗ[ℂ] F) ∘ₗ S.subtype) = S.map (P : F →ₗ[ℂ] F) := by
      rw [LinearMap.range_comp]
      simp
    rw [← hr, LinearMap.finrank_range_of_inj hinj, hrank]
  refine ⟨S.map (P : F →ₗ[ℂ] F), ?_, hrk, ?_⟩
  · rintro y ⟨x, -, rfl⟩
    exact (galerkinSpan b m).starProjection_apply_mem x
  · refine csSup_le
      (rayleighSetOn_nonempty T (S := S.map (P : F →ₗ[ℂ] F)) (by rw [hrk]; omega)) ?_
    rintro t ⟨y, hy, hy1, rfl⟩
    obtain ⟨x, hxS, rfl⟩ := hy
    simp only [ContinuousLinearMap.coe_coe] at hy1 ⊢
    have hxnorm : ‖P x - x‖ ≤ δ * ‖x‖ := hbnd x hxS
    have hx0 : x ≠ 0 := by
      rintro rfl
      simp at hy1
    have hxpos : 0 < ‖x‖ := norm_pos_iff.mpr hx0
    have habs : |‖x‖ - 1| ≤ δ * ‖x‖ := by
      have h1 := abs_norm_sub_norm_le x (P x)
      rw [hy1, norm_sub_rev] at h1
      exact h1.trans hxnorm
    have hxle : ‖x‖ ≤ 2 := by
      have h2 := abs_le.mp habs
      nlinarith [h2.2]
    set u : F := (‖x‖⁻¹ : ℂ) • x with hu
    have hunorm : ‖u‖ = 1 := by
      rw [hu, norm_smul]
      simp [hxpos.ne']
    have huS : u ∈ S := S.smul_mem _ hxS
    have hxu : ‖x - u‖ = |‖x‖ - 1| := by
      have hxe : x - u = ((1 - ‖x‖⁻¹ : ℝ) : ℂ) • x := by
        rw [hu]
        push_cast
        module
      have key : (1 - ‖x‖⁻¹) * ‖x‖ = ‖x‖ - 1 := by field_simp
      rw [hxe, norm_smul]
      simp only [Complex.norm_real, Real.norm_eq_abs]
      calc |1 - ‖x‖⁻¹| * ‖x‖ = |1 - ‖x‖⁻¹| * |‖x‖| := by rw [abs_of_pos hxpos]
        _ = |(1 - ‖x‖⁻¹) * ‖x‖| := (abs_mul _ _).symm
        _ = |‖x‖ - 1| := by rw [key]
    have hyu : ‖P x - u‖ ≤ 2 * (δ * ‖x‖) := by
      calc ‖P x - u‖ ≤ ‖P x - x‖ + ‖x - u‖ := by
            simpa using norm_sub_le_norm_sub_add_norm_sub (P x) x u
        _ ≤ δ * ‖x‖ + δ * ‖x‖ := by rw [hxu]; linarith [habs]
        _ = 2 * (δ * ‖x‖) := by ring
    have hdiff := rayleighVal_sub_le T (P x) u
    rw [hy1, hunorm] at hdiff
    have hbound2 : rayleighVal T (P x) - rayleighVal T u ≤ ε := by
      have h4 : ‖P x - u‖ ≤ 4 * δ := by nlinarith [hyu, hxle, hδpos.le]
      calc rayleighVal T (P x) - rayleighVal T u ≤ c * (1 + 1) * ‖P x - u‖ := hdiff
        _ ≤ c * (1 + 1) * (4 * δ) := mul_le_mul_of_nonneg_left h4 (by linarith)
        _ = 8 * c * δ := by ring
        _ ≤ ε := hδeps
    have hle := rayleighVal_le_rayleighSup T huS hunorm
    linarith
