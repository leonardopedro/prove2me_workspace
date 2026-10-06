-- Generated from ChapterA4e.lean — solution of BookProof.ChapterA4e.projNeg_idem
import Mathlib
import Definitions.Def_ChapterA4e
import Theorems.Thm_BookProof_ChapterA4e_enSign_sq
open BookProof.ChapterA4e



open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

set_option maxHeartbeats 1000000 in
theorem solution : projNeg * projNeg = projNeg := by

  have h : (Complex.I • enSign) * (Complex.I • enSign) = 1 := by
    rw [smul_mul_smul_comm, enSign_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 + Complex.I • enSign) * (1 + Complex.I • enSign)
      = (2 : ℂ) • (1 + Complex.I • enSign) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, h]
    module
  rw [projNeg, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num
