-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.zeta_le_one
import Mathlib
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (x : ℝ) : zeta r x ≤ 1 := bumpG.le_one
