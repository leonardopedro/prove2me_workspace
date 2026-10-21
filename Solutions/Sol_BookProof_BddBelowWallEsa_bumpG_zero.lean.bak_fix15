-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.bumpG_zero
import Mathlib
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : 2 ≤ |x|) : (bumpG : ℝ → ℝ) x = 0 := by

  refine bumpG.zero_of_le_dist ?_
  simpa [Real.dist_eq, bumpG] using hx
