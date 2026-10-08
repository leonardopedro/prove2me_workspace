-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projAsym_idem
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_sq
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : projAsym * projAsym = projAsym := by

  unfold projAsym
  rw [Matrix.smul_mul, Matrix.mul_smul, smul_smul]
  have key : (1 - BookProof.ChapterA3l.swap) * (1 - BookProof.ChapterA3l.swap) = (2 : ℂ) • (1 - BookProof.ChapterA3l.swap) := by
    rw [sub_mul, mul_sub, mul_sub, one_mul, one_mul, mul_one, swap_sq]
    module
  rw [key, smul_smul]
  norm_num
