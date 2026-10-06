-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.polar_radial
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.polar_radial {δ : ℝ} (hδ : 0 < δ) (G : ℂ → ℂ) (hG : Continuous G) :
    ∫ u : ℂ, (moll δ u : ℂ) * G u
      = ∫ r in Ioi (0 : ℝ), ((r * moll δ r : ℝ) : ℂ) *
          ∫ θ in (-π)..π, G (Complex.polarCoord.symm (r, θ)) := by sorry
