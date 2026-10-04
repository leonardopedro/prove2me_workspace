-- Generated from ChapterConformalFiberDeficiency.lean — theorem BookProof.ConformalFiberDeficiency.cfV_not_deficiencyTrivialAt_I
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterA4
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.ConformalFiberDeficiency



open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.ConformalFiberDeficiency.cfV_not_deficiencyTrivialAt_I :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam cfV contDiff_cfV) Complex.I := by sorry
