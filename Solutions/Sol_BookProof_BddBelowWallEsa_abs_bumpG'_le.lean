-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.abs_bumpG'_le
import Mathlib
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : |bumpG' x| ≤ bumpM := by

  have h := (hasCompactSupport_bumpG'.exists_bound_of_continuous continuous_bumpG').choose_spec x
  simpa [Real.norm_eq_abs, bumpM] using h
