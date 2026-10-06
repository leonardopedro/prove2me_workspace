-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.projPos_mul_projNeg
import Mathlib
import Definitions.Def_ChapterA4e
import Theorems.Thm_BookProof_ChapterA4e_enSign_sq
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution : projPos * projNeg = 0 := by

  have key : (1 - Complex.I • enSign) * (1 + Complex.I • enSign) = 0 := by
    have h : (Complex.I • enSign) * (Complex.I • enSign) = 1 := by
      rw [smul_mul_smul_comm, enSign_sq, Complex.I_mul_I, smul_neg, neg_smul,
        one_smul, neg_neg]
    rw [sub_mul, one_mul, mul_add, mul_one, h]
    abel
  rw [projPos, projNeg, Matrix.smul_mul, Matrix.mul_smul, key, smul_zero, smul_zero]
