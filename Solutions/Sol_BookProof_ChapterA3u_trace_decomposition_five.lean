-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.trace_decomposition_five
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_trace_projSym_five
import Theorems.Thm_BookProof_ChapterA3u_trace_projAnti_five
import Theorems.Thm_BookProof_ChapterA3u_trace_projMixed_five
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution :
    Matrix.trace (projSym 5) + Matrix.trace (projAnti 5)
        + Matrix.trace (projMixed 5) = 1024 := by

  rw [trace_projSym_five, trace_projAnti_five, trace_projMixed_five]
  norm_num
