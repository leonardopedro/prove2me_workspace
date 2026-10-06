-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projSym_idem
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_sq
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : projSym * projSym = projSym := by

  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 + swap) * (1 + swap) = (2 : ℂ) • (1 + swap) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, swap_sq]
    module
  rw [key, smul_smul]
  norm_num
