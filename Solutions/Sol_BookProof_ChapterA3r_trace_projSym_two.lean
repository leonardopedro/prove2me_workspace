-- Generated from ChapterA3r.lean — solution of BookProof.ChapterA3r.trace_projSym_two
import Mathlib
import Definitions.Def_ChapterA3r
import Theorems.Thm_BookProof_ChapterA3r_trace_permMat
open BookProof.ChapterA3r



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projSym 2) = 10 := by

  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun σ _ => trace_permMat σ ];
  rw [ div_mul_eq_mul_div, div_eq_iff ] <;> norm_cast
