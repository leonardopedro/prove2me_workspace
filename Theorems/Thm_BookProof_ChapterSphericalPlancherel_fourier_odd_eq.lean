-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.fourier_odd_eq
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.fourier_odd_eq (G : ℝ → ℂ) (hG : Integrable G) (hodd : ∀ x, G (-x) = -G x) (w : ℝ) :
    𝓕 G w = -(2 * Complex.I) * sineTransform G w := by sorry
