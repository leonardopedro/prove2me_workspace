-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.integral_moll_eq_self_of_analytic
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.integral_moll_eq_self_of_analytic {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hh : DifferentiableOn ℂ h s) (hcont : Continuous h) {δ : ℝ} (hδ : 0 < δ) {z : ℂ}
    (hz : closedBall z δ ⊆ s) :
    ∫ w : ℂ, (moll δ (z - w) : ℂ) * h w = h z := by sorry
