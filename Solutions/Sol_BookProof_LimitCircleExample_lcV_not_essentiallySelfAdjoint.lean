-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.lcV_not_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_contDiff_lcV
import Theorems.Thm_BookProof_LimitCircleExample_lcSol_ne_zero
import Theorems.Thm_BookProof_LimitCircleExample_lcSol_isL2Ode
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_essentiallySelfAdjointOn_of_l2_solution
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ EssentiallySelfAdjointOn (ccDomain ℝ) (wallHam lcV contDiff_lcV) := not_essentiallySelfAdjointOn_of_l2_solution _ _ lcSol_isL2Ode ⟨0, lcSol_ne_zero 0⟩
