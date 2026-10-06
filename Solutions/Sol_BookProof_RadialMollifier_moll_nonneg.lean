-- Generated from ChapterRadialMollifier.lean — solution of BookProof.RadialMollifier.moll_nonneg
import Mathlib
import Definitions.Def_ChapterRadialMollifier
import Theorems.Thm_BookProof_RadialMollifier_radialBump_nonneg
import Theorems.Thm_BookProof_RadialMollifier_radialMass_pos
open BookProof.RadialMollifier




open MeasureTheory Metric Set Complex intervalIntegral Real
open scoped Convolution Topology ContDiff Real

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (δ : ℝ) (z : ℂ) : 0 ≤ moll δ z := by

  exact div_nonneg (radialBump_nonneg _) (mul_nonneg radialMass_pos.le (sq_nonneg δ))
