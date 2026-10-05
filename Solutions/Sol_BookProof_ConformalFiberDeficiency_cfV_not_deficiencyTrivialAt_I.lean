-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfV_not_deficiencyTrivialAt_I
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_contDiff_cfV
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfSol_ne_zero
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfSol_isL2Ode
import Theorems.Thm_BookProof_WallDeficiencyObstruction_not_deficiencyTrivialAt_of_l2_solution
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam cfV contDiff_cfV) Complex.I := not_deficiencyTrivialAt_of_l2_solution _ _ Complex.I cfSol_isL2Ode ⟨0, cfSol_ne_zero 0⟩
