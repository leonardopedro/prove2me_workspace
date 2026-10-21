-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.continuous_zeta'
import Mathlib
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (r : ℝ) : Continuous (zeta' r) := (continuous_bumpG'.comp (continuous_id.div_const r)).div_const r
