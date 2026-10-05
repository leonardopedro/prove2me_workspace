-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.projSym3_parityDiag_comm
import Mathlib
import Definitions.Def_ChapterA3m
import Theorems.Thm_BookProof_ChapterA3m_swap12_parityDiag_comm
import Theorems.Thm_BookProof_ChapterA3m_swap23_parityDiag_comm
import Theorems.Thm_BookProof_ChapterA3m_swap13_parityDiag_comm
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution :
    projSym3 * parityDiag3 = parityDiag3 * projSym3 := by

  rw [ show projSym3 = ( 6 : ℂ ) ⁻¹ • ( 1 + swap12 + swap23 + swap12 * swap23 + swap23 * swap12 +
      swap13 ) from rfl ];
  simp [ Matrix.add_mul, Matrix.mul_add, mul_assoc ];
  simp only [swap12_parityDiag_comm, swap23_parityDiag_comm, ← Matrix.mul_assoc,
      swap13_parityDiag_comm]
