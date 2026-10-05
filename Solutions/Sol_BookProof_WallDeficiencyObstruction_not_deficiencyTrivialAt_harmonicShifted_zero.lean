-- Generated from ChapterWallDeficiencyObstruction.lean — solution of BookProof.WallDeficiencyObstruction.not_deficiencyTrivialAt_harmonicShifted_zero
import Mathlib
import Definitions.Def_ChapterWallDeficiencyObstruction
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_deficiencyTrivialAt_of_l2_solution
import Theorems.Thm_BookProof_WallDeficiencyObstruction_contDiff_harmonicShiftedV
import Theorems.Thm_BookProof_WallDeficiencyObstruction_gaussianState_isL2Ode
open BookProof.WallDeficiencyObstruction




open MeasureTheory SchwartzMap Set
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.ScalaronWallEsa
open BookProof.WeakSecondDeriv

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam harmonicShiftedV contDiff_harmonicShiftedV) 0 :=
  not_deficiencyTrivialAt_of_l2_solution _ _ 0 gaussianState_isL2Ode
      ⟨0, by simp [gaussianState]⟩
