-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfLogFun
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfP
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfQ
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) :
    HasDerivAt (fun t : ℝ => ((cfP t : ℝ) : ℂ) + Complex.I * ((cfQ t : ℝ) : ℂ))
      (cfLog' y) y := ((hasDerivAt_cfP y).ofReal_comp).add (((hasDerivAt_cfQ y).ofReal_comp).const_mul Complex.I)
