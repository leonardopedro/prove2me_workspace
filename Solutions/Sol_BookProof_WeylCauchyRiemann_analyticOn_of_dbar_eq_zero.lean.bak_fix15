-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.analyticOn_of_dbar_eq_zero
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hg : ∀ z ∈ s, DifferentiableAt ℝ g z) (hdbar : ∀ z ∈ s, dbar g z = 0) :
    AnalyticOn ℂ g s := by

  refine BookProof.ChapterHolomorphic.cauchyRiemann_analyticOn hs hg fun z hz => ?_
  have h := hdbar z hz
  simp only [dbar] at h
  have hI : fderiv ℝ g z Complex.I = Complex.I * fderiv ℝ g z 1 := by
    linear_combination (-Complex.I) * h + (fderiv ℝ g z Complex.I) * Complex.I_sq
  simpa [smul_eq_mul] using hI
