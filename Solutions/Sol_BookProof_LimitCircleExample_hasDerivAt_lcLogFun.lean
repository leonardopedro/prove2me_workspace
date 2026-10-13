-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcLogFun
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcP
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcQ
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
theorem solution (x : ℝ) :
    HasDerivAt (fun y : ℝ => ((lcP y : ℝ) : ℂ) + Complex.I * ((lcQ y : ℝ) : ℂ))
      (lcLog' x) x := ((hasDerivAt_lcP x).ofReal_comp).add (((hasDerivAt_lcQ x).ofReal_comp).const_mul Complex.I)
