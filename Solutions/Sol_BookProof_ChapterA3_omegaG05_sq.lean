-- Generated from ChapterA3d.lean — solution of BookProof.ChapterA3.omegaG05_sq
import Mathlib
import Definitions.Def_ChapterA3d
import Theorems.Thm_BookProof_ChapterA3_castMat_neg_one
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : omegaG05 * omegaG05 = -1 := by

  have h : (omegaG05Z * omegaG05Z) = -1 := by decide
  unfold omegaG05
  rw [← map_mul, h, castMat_neg_one]
