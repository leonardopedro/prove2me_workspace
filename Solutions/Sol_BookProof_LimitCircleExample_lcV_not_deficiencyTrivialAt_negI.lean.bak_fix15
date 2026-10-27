-- Generated from ChapterLimitCircleExample.lean — solution of BookProof.LimitCircleExample.lcV_not_deficiencyTrivialAt_negI
import Mathlib
import Definitions.Def_ChapterLimitCircleExample
import Theorems.Thm_BookProof_LimitCircleExample_contDiff_lcV
import Theorems.Thm_BookProof_LimitCircleExample_lcV_not_deficiencyTrivialAt_I
import Theorems.Thm_BookProof_WallDeficiencyObstruction_deficiencyTrivialAt_conj_iff
open BookProof.LimitCircleExample




open MeasureTheory Real
open BookProof.FarisLavine BookProof.ScalaronEsa BookProof.ScalaronWallEsa
open BookProof.WallDeficiencyObstruction

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ¬ DeficiencyTrivialAt (ccDomain ℝ) (wallHam lcV contDiff_lcV) (-Complex.I) := by

  have h := lcV_not_deficiencyTrivialAt_I
  rw [deficiencyTrivialAt_conj_iff lcV contDiff_lcV Complex.I] at h
  simpa using h
