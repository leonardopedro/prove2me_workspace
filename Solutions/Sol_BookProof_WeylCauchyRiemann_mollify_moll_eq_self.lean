-- Generated from ChapterWeylCauchyRiemann.lean — solution of BookProof.WeylCauchyRiemann.mollify_moll_eq_self
import Mathlib
import Definitions.Def_ChapterWeylCauchyRiemann
import Theorems.Thm_BookProof_RadialMollifier_integral_moll_eq_self_of_analytic
open BookProof.WeylCauchyRiemann




open MeasureTheory Metric Set Filter Complex BookProof.RadialMollifier
open scoped Convolution Topology ContDiff

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {h : ℂ → ℂ} {s : Set ℂ} (hs : IsOpen s)
    (hh : DifferentiableOn ℂ h s) (hcont : Continuous h) {δ : ℝ} (hδ : 0 < δ) {z : ℂ}
    (hz : closedBall z δ ⊆ s) : mollify h (moll δ) z = h z := integral_moll_eq_self_of_analytic hs hh hcont hδ hz
