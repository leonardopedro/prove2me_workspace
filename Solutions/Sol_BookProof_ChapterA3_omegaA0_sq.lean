-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.omegaA0_sq
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_castMat_neg_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : omegaA0 * omegaA0 = -1 := by

  have h : (mgammaZ 0 * mgammaZ 0) = -1 := by decide
  unfold omegaA0 mgammaR
  rw [← map_mul, h, castMat_neg_one]
