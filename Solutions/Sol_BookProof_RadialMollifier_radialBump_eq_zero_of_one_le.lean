-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_eq_zero_of_one_le
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {z : ℂ} (h : 1 ≤ ‖z‖) : radialBump z = 0 := by

  refine expNegInvGlue.zero_of_nonpos ?_
  have : (1 : ℝ) ≤ ‖z‖ ^ 2 := by nlinarith [norm_nonneg z]
  simp only [Complex.normSq_eq_norm_sq]
  linarith
