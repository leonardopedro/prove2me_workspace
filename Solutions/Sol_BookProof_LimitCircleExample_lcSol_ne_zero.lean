-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.lcSol_ne_zero
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) : lcSol x ≠ 0 := Complex.exp_ne_zero _
