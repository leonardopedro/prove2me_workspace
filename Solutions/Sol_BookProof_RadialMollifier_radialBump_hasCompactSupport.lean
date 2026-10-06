-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialBump_hasCompactSupport
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_radialBump_support
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : HasCompactSupport radialBump := by

  apply HasCompactSupport.of_support_subset_isCompact (isCompact_closedBall (0 : ℂ) 1)
  rw [radialBump_support]
  exact ball_subset_closedBall
