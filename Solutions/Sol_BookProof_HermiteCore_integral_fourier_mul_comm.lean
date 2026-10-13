-- Generated from ChapterHermiteFunctions.lean — solution of BookProof.HermiteCore.integral_fourier_mul_comm
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore




open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

set_option maxHeartbeats 1000000 in

theorem solution {f g : ℝ → ℂ} (hf : Integrable f) (hg : Integrable g) :
    ∫ xi : ℝ, 𝓕 f xi * g xi = ∫ x : ℝ, f x * 𝓕 g x := by
  have hflip : ((innerₗ ℝ) : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ).flip = innerₗ ℝ := by ext; simp
  have h := VectorFourier.integral_bilin_fourierIntegral_eq_flip
    (V := ℝ) (W := ℝ) (E := ℂ) (F := ℂ) (G := ℂ) (μ := volume) (ν := volume)
    (L := innerₗ ℝ) (e := Real.fourierChar) (f := f) (g := g)
    (ContinuousLinearMap.mul ℂ ℂ) Real.continuous_fourierChar (by fun_prop) hf hg
  simpa [hflip, ContinuousLinearMap.mul_apply', FourierTransform.fourier] using h
