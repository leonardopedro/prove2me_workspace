-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.trace_projMixed_five
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_trace_projSym_five
import Theorems.Thm_BookProof_ChapterA3u_trace_projAnti_five
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projMixed 5) = 968 := by

  unfold projMixed; norm_num;
  rw [ trace_projSym_five, trace_projAnti_five ] ; norm_num
