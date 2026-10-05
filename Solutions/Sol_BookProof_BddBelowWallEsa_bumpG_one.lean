-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.bumpG_one
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {x : ℝ} (hx : |x| ≤ 1) : (bumpG : ℝ → ℝ) x = 1 := by

  refine bumpG.one_of_mem_closedBall ?_
  simpa [Real.dist_eq, bumpG] using hx
