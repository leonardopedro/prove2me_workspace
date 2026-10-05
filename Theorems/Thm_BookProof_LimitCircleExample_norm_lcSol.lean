-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.norm_lcSol
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Definitions.Def_ChapterWallDeficiencyObstruction
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
open BookProof.LimitCircleExample



open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.LimitCircleExample.norm_lcSol (x : ℝ) : ‖lcSol x‖ = Real.exp (lcP x) := by sorry
