-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.zeta_nonneg
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) (x : ℝ) : 0 ≤ zeta r x := bumpG.nonneg
