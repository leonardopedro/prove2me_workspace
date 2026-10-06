-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.radialMass_pos
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_radialBump_nonneg
import Theorems.Thm_BookProof_RadialMollifier_radialBump_support
import Theorems.Thm_BookProof_RadialMollifier_radialBump_integrable
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : 0 < radialMass := by

  rw [radialMass]
  rw [integral_pos_iff_support_of_nonneg radialBump_nonneg radialBump_integrable]
  rw [radialBump_support]
  simpa using (measure_ball_pos volume (0 : ℂ) one_pos)
