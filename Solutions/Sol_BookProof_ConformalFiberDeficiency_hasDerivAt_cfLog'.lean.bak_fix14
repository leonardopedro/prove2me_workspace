-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.hasDerivAt_cfLog'
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfP_prime
import Theorems.Thm_BookProof_ConformalFiberDeficiency_hasDerivAt_cfQ_prime
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (y : ℝ) :
    HasDerivAt cfLog' (((cfP'' y : ℝ) : ℂ) + Complex.I * ((-Real.exp (-y) : ℝ) : ℂ)) y :=
  ((hasDerivAt_cfP_prime y).ofReal_comp).add
      (((hasDerivAt_cfQ_prime y).ofReal_comp).const_mul Complex.I)
