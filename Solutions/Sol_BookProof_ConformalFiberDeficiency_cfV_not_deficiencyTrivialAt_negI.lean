-- Generated from ChapterConformalFiberDeficiency.lean — solution of BookProof.ConformalFiberDeficiency.cfV_not_deficiencyTrivialAt_negI
import Mathlib
import Definitions.Def_ChapterConformalFiberDeficiency
import Theorems.Thm_BookProof_ConformalFiberDeficiency_contDiff_cfV
import Theorems.Thm_BookProof_ConformalFiberDeficiency_cfV_not_deficiencyTrivialAt_I
import Theorems.Thm_BookProof_WallDeficiencyObstruction_deficiencyTrivialAt_conj_iff
open BookProof.ConformalFiberDeficiency




open MeasureTheory Real Filter Topology
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam cfV contDiff_cfV) (-Complex.I) := by

  have h := cfV_not_deficiencyTrivialAt_I
  rw [deficiencyTrivialAt_conj_iff cfV contDiff_cfV Complex.I] at h
  simpa using h
