-- Generated from ChapterA3r.lean — solution of BookProof.ChapterA3r.trace_decomposition_two
import Mathlib
import Definitions.Def_ChapterA3r
import Theorems.Thm_BookProof_ChapterA3r_trace_projSym_two
import Theorems.Thm_BookProof_ChapterA3r_trace_projAnti_two
import Theorems.Thm_BookProof_ChapterA3r_trace_projMixed_two
open BookProof.ChapterA3r



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution :
    Matrix.trace (projSym 2) + Matrix.trace (projAnti 2)
        + Matrix.trace (projMixed 2) = 16 := by

  rw [trace_projSym_two, trace_projAnti_two, trace_projMixed_two]
  norm_num
