-- Generated from ChapterConformalFiberDeficiency.lean — theorem BookProof.ConformalFiberDeficiency.cfV_not_essentiallySelfAdjoint
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
open BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.ConformalFiberDeficiency



open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.ConformalFiberDeficiency.cfV_not_essentiallySelfAdjoint :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam cfV contDiff_cfV) := by sorry
