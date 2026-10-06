-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projSym_mul_projAsym
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_sq
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : projSym * projAsym = 0 := by

  unfold projSym projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 + swap) * (1 - swap) = 0 := by
    rw [add_mul, one_mul, mul_sub, mul_one, swap_sq]
    abel
  rw [key, smul_zero]
