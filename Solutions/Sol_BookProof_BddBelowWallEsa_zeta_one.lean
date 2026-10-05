-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.zeta_one
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_bumpG_one
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {r : ℝ} (hr : 0 < r) {x : ℝ} (hx : |x| ≤ r) : zeta r x = 1 := by

  refine bumpG_one ?_
  rw [abs_div, abs_of_pos hr, div_le_one hr]
  exact hx
