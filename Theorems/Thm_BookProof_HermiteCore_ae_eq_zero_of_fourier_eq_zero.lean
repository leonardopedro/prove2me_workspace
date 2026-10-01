-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.ae_eq_zero_of_fourier_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

rₗ ℝ) : ℝ →ₗ[ℝ] ℝ →ₗ[ℝ] ℝ).flip = innerₗ ℝ := by ext; simp
  have h := VectorFourier.integral_bilin_fourierIntegral_eq_flip
    (V := ℝ) (W := ℝ) (E := ℂ) (F := ℂ) (G := ℂ) (μ := volume) (ν := volume)
    (L := innerₗ ℝ) ( := by sorry
