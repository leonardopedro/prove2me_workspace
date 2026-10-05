-- Generated from ChapterA3u.lean — solution of BookProof.ChapterA3u.trace_projSym_five
import Mathlib
import Definitions.Def_ChapterA3u
import Theorems.Thm_BookProof_ChapterA3u_trace_permMat_pow
open BookProof.ChapterA3u



open Matrix
open scoped BigOperators


open BookProof.ChapterA3n BookProof.ChapterA3o BookProof.ChapterA3q
open BookProof.ChapterA3r

set_option maxHeartbeats 1000000 in
theorem solution : Matrix.trace (projSym 5) = 56 := by

  unfold projSym; norm_num;
  rw [ Finset.sum_congr rfl fun x _ => trace_permMat_pow x ] ; norm_cast;
  field_simp;
  exact mod_cast by decide
