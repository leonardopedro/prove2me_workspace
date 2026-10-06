-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_pos_of_lt_one
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {z : ℂ} (h : ‖z‖ < 1) : 0 < radialBump z := by

  refine expNegInvGlue.pos_of_pos ?_
  have : ‖z‖ ^ 2 < 1 := by nlinarith [norm_nonneg z]
  simp only [Complex.normSq_eq_norm_sq]
  linarith
