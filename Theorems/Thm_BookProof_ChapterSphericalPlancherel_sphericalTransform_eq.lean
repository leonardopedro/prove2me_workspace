-- Generated from ChapterSphericalPlancherel.lean — theorem BookProof.ChapterSphericalPlancherel.sphericalTransform_eq
import Mathlib
import Definitions.Def_ChapterSphericalPlancherel
import Definitions.Def_ChapterSphericalBessel
open BookProof.ChapterSphericalBessel
open BookProof.ChapterSphericalPlancherel



open MeasureTheory Set Real SchwartzMap
open scoped FourierTransform ContDiff
open BookProof.ChapterSphericalBessel

theorem BookProof.ChapterSphericalPlancherel.sphericalTransform_eq {f : ℝ → ℂ} {G : ℝ → ℂ}
    (hf : ∀ r ∈ Ioi (0 : ℝ), (r : ℂ) * f r = G r) {p : ℝ} (hp : 0 < p) :
    sphericalTransform f p
      = (Real.sqrt (2 / π) : ℂ) * ((p : ℂ)⁻¹ * sineKernelTransform G p) := by sorry
