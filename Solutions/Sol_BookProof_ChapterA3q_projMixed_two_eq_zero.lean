-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projMixed_two_eq_zero
import Mathlib
import Definitions.Def_ChapterA3q
import Theorems.Thm_BookProof_ChapterA3p_projSym_add_projAnti_two
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution : projMixed 2 = 0 := by

  unfold projMixed
  rw [← projSym_add_projAnti_two]; abel
