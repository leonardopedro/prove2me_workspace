-- Generated from ChapterConformalFiberDeficiency.lean — theorem BookProof.ConformalFiberDeficiency.cfV_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
open BookProof.ConformalFiberDeficiency



open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.ConformalFiberDeficiency.cfV_le (y : ℝ) : cfV y ≤ 1 / 4 - Real.exp (-(2 * y)) := by sorry
