-- Generated from ChapterAngularMomentum.lean — theorem BookProof.ChapterAngularMomentum.angularMomentum_eigen
import Mathlib
import Definitions.Def_ChapterAngularMomentum
open BookProof.ChapterAngularMomentum



open Complex

theorem BookProof.ChapterAngularMomentum.angularMomentum_eigen {u : ℂ → ℂ} {μ : ℝ} {z : ℂ}
    (hdiff : DifferentiableAt ℝ u z)
    (hequiv : ∀ t : ℝ, u (Complex.exp ((t : ℂ) * Complex.I) * z)
      = Complex.exp ((μ : ℂ) * (t : ℂ) * Complex.I) * u z) :
    -Complex.I * (z.re * fderiv ℝ u z Complex.I - z.im * fderiv ℝ u z 1) = (μ : ℂ) * u z := by sorry
