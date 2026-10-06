-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.projSym_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_spinGenDiag_comm
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    projSym * spinGenDiag μ ν = spinGenDiag μ ν * projSym := by

  unfold projSym
  rw [Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_add, one_mul, mul_one,
    swap_spinGenDiag_comm]
