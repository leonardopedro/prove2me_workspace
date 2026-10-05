-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.hasDerivAt_lcLog'
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcP'
import Theorems.Thm_BookProof_LimitCircleExample_hasDerivAt_lcQ'
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (x : ℝ) :
    HasDerivAt lcLog' (((lcP'' x : ℝ) : ℂ) + Complex.I * ((-x : ℝ) : ℂ)) x := ((hasDerivAt_lcP' x).ofReal_comp).add (((hasDerivAt_lcQ' x).ofReal_comp).const_mul Complex.I)
