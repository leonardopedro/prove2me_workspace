-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.ae_eq_zero_of_fourier_eq_zero
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.ae_eq_zero_of_fourier_eq_zero {v : ℝ → ℂ} (hv : Integrable v)
    (h : ∀ w : ℝ, 𝓕 v w = 0) : ∀ᵐ x : ℝ, v x = 0 := by sorry
