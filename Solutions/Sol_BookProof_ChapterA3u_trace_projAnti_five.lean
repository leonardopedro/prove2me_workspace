-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.trace_projAnti_five
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_trace_permMat_pow
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projAnti 5) = 0 := by

  unfold projAnti;
  simp [signC, trace_permMat_pow];
  norm_cast
