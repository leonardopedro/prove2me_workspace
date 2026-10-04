-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.lcSol_sq_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterScalaronWallEsa
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Definitions.Def_ChapterA4
open BookProof.LimitCircleExample



open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

theorem BookProof.LimitCircleExample.lcSol_sq_le (x : ℝ) : ‖lcSol x‖ ^ 2 ≤ Real.exp π * (1 + x ^ 2)⁻¹ := by sorry
