-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.lcV_not_deficiencyTrivialAt_I
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_contDiff_lcV
import Theorems.Thm_BookProof_LimitCircleExample_lcSol_ne_zero
import Theorems.Thm_BookProof_LimitCircleExample_lcSol_isL2Ode
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_deficiencyTrivialAt_of_l2_solution
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam lcV contDiff_lcV) Complex.I := not_deficiencyTrivialAt_of_l2_solution _ _ Complex.I lcSol_isL2Ode ⟨0, lcSol_ne_zero 0⟩
