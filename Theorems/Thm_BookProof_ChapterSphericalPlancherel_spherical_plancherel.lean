-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.spherical_plancherel
import Definitions.Def_ChapterSphericalBessel
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.spherical_plancherel (G : 𝓢(ℝ, ℂ)) (hodd : ∀ x, G (-x) = -G x)
    (f : ℝ → ℂ) (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) :
    ∫ p in Ioi (0 : ℝ), ‖sphericalTransform f p‖ ^ 2 * p ^ 2
      = ∫ r in Ioi (0 : ℝ), ‖f r‖ ^ 2 * r ^ 2 := by sorry
