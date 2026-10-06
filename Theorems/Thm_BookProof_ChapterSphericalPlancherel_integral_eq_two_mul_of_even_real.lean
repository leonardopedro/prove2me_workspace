-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.integral_eq_two_mul_of_even_real
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.integral_eq_two_mul_of_even_real (h : ℝ → ℝ) (he : ∀ x, h (-x) = h x) :
    ∫ x : ℝ, h x = 2 * ∫ x in Ioi (0 : ℝ), h x := by sorry
