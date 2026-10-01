-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.ae_eq_zero_of_fourier_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
import Theorems.Thm_BookProof_HermiteCore_integral_fourier_mul_comm
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in
rₗ ℝ) : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ).flip = innerₗ ℝ := by ext; simp
  have h := VectorFourier.integral_bilin_fourierIntegral_eq_flip
    (V := ℝ) (W := ℝ) (E := ℂ) (F := ℂ) (G := ℂ) (μ := volume) (ν := volume)
    (L := innerₗ ℝ) ( :=
  e := Real.fourierChar) (f := f) (g := g)
      (ContinuousLinearMap.mul ℂ ℂ) Real.continuous_fourierChar (by fun_prop) hf hg
    simpa [hflip, ContinuousLinearMap.mul_apply', FourierTransform.fourier] using h
  
  /-- **Fourier uniqueness**: an integrable function whose Fourier transform
  vanishes identically is zero almost everywhere. -/
  theorem ae_eq_zero_of_fourier_eq_zero {v : ℝ → ℂ} (hv : Integrable v)
      (h : ∀ w : ℝ, 𝓕 v w = 0) : ∀ᵐ x : ℝ, v x = 0 := by
    refine ae_eq_zero_of_integral_contDiff_smul_eq_zero hv.locallyIntegrable ?_
    intro g hg hgsupp
    set psi : 𝓢(ℝ, ℂ) := HasCompactSupport.toSchwartzMap
      (f := fun x : ℝ => ((g x : ℝ) : ℂ))
      (by exact hgsupp.comp_left (g := fun r : ℝ => (r : ℂ)) (by simp))
      (Complex.ofRealCLM.contDiff.comp hg) with hpsi
    set phi : 𝓢(ℝ, ℂ) := 𝓕⁻ psi with hphi
    have hfourier : 𝓕 (phi : ℝ → ℂ) = (psi : ℝ → ℂ) := by
      rw
