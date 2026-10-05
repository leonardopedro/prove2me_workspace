-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.bumpM_nonneg
import Mathlib
import Definitions.Def_ChapterBddBelowWallEsa
import Theorems.Thm_BookProof_BddBelowWallEsa_abs_bumpG'_le
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : 0 ≤ bumpM := le_trans (abs_nonneg _) (abs_bumpG'_le 0)
