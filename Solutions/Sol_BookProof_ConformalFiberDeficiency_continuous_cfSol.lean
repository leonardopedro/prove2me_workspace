-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.continuous_cfSol
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfSol
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : Continuous cfSol := continuous_iff_continuousAt.2 fun y => (hasDerivAt_cfSol y).continuousAt
