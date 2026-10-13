-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.continuous_lcSol
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcSol
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
theorem solution : Continuous lcSol := continuous_iff_continuousAt.2 fun x => (hasDerivAt_lcSol x).continuousAt
