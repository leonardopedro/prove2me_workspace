-- Generated from ChapterRadialMollifier.lean — theorem BookProof.RadialMollifier.circle_integral_eq
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier



open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

theorem BookProof.RadialMollifier.circle_integral_eq {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s) (hh : DifferentiableOn ℂ h s)
    {z : ℂ} {r : ℝ} (hr : 0 < r) (hsub : closedBall z r ⊆ s) :
    ∫ θ in (-π)..π, h (z - (r : ℂ) * Complex.exp (θ * Complex.I)) = ((2 * π : ℝ) : ℂ) * h z := by sorry
