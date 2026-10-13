-- Generated from ChapterHermiteFunctions.lean — theorem BookProof.HermiteCore.integral_fourier_mul_comm
import Mathlib
import Definitions.Def_ChapterHermiteFunctions
open BookProof.HermiteCore



open MeasureTheory Polynomial Filter Topology FourierTransform SchwartzMap

noncomputable section

theorem BookProof.HermiteCore.integral_fourier_mul_comm {f g : ℝ → ℂ} (hf : Integrable f) (hg : Integrable g) :
    ∫ xi : ℝ, 𝓕 f xi * g xi = ∫ x : ℝ, f x * 𝓕 g x := by sorry