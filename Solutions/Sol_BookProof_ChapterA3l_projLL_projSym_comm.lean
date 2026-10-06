-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projLL_projSym_comm
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_projLL_comm
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : projLL * projSym = projSym * projLL := by

  unfold projSym
  rw [Matrix.mul_smul, Matrix.smul_mul, mul_add, add_mul, mul_one, one_mul,
    swap_projLL_comm]
