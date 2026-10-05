-- Generated from ChapterA3r.lean — solution of BookProof.ChapterA3r.trace_projAnti_two
import Mathlib
import Definitions.Def_ChapterA3r
import Theorems.Thm_BookProof_ChapterA3r_trace_permMat
open BookProof.ChapterA3r



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projAnti 2) = 6 := by

  unfold projAnti; norm_num;
  simp only [one_div, signC, trace_permMat];
  rw [ inv_mul_eq_div, div_eq_iff ] <;> norm_cast
