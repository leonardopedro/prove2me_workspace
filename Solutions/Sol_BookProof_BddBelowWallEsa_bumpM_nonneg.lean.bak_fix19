-- Generated from ChapterBddBelowWallEsa.lean — solution of BookProof.BddBelowWallEsa.bumpM_nonneg
import Mathlib
import Theorems.Thm_BookProof_BddBelowWallEsa_abs_bumpG_prime_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Definitions.Def_ChapterWeakSecondDerivative
import Definitions.Def_ChapterBddBelowWallEsa
open BookProof.BddBelowWallEsa




open MeasureTheory Metric Filter Topology Set
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : 0 ≤ bumpM := le_trans (abs_nonneg _) (abs_bumpG'_le 0)
