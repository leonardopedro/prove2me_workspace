-- Generated from ChapterLimitCircleExample.lean — theorem BookProof.LimitCircleExample.hasDerivAt_lcLogFun
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

theorem BookProof.LimitCircleExample.hasDerivAt_lcLogFun (x : ℝ) :
    HasDerivAt (fun y : ℝ => ((lcP y : ℝ) : ℂ) + Complex.I * ((lcQ y : ℝ) : ℂ))
      (lcLog' x) x := by sorry
