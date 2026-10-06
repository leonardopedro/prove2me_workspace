-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.fourier_eq_cos_sub_sin
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.fourier_eq_cos_sub_sin (f : ℝ → ℂ) (w : ℝ) :
    𝓕 f w = ∫ x : ℝ, ((Real.cos (2 * π * (x * w)) : ℂ)
      - (Real.sin (2 * π * (x * w)) : ℂ) * Complex.I) * f x := by sorry
