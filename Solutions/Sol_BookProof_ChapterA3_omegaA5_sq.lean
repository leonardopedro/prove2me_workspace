-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.omegaA5_sq
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_castMat_neg_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : omegaA5 * omegaA5 = -1 := by

  have h : (mgamma5Z * mgamma5Z) = -1 := by decide
  unfold omegaA5 omegaA5Z
  rw [← map_mul, h, castMat_neg_one]
