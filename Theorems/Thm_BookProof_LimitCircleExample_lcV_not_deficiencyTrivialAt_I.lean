-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.lcV_not_deficiencyTrivialAt_I
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.LimitCircleExample



open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.LimitCircleExample.lcV_not_deficiencyTrivialAt_I :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam lcV contDiff_lcV) Complex.I := by sorry
