-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_congr_norm
import Mathlib
import Definitions.Def_ChapterRadialMollifier
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {z w : ℂ} (h : ‖z‖ = ‖w‖) :
    radialBump z = radialBump w := by

  simp only [radialBump, Complex.normSq_eq_norm_sq, h]
