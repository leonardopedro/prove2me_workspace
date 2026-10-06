-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.moll_congr_norm
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_radialBump_congr_norm
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {δ : ℝ} {z w : ℂ} (h : ‖z‖ = ‖w‖) : moll δ z = moll δ w := by

  simp only [moll]
  congr 1
  refine radialBump_congr_norm ?_
  simp [h]
