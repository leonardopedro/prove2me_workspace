-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.lcV_not_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.LimitCircleExample



open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.LimitCircleExample.lcV_not_essentiallySelfAdjoint :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam lcV contDiff_lcV) := by sorry
