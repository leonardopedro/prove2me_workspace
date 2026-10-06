-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.projChirR_idem
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_chir_sq
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : projChirR * projChirR = projChirR := by

  have h : (Complex.I • chir) * (Complex.I • chir) = 1 := by
    rw [smul_mul_smul_comm, chir_sq, Complex.I_mul_I, smul_neg, neg_smul,
      one_smul, neg_neg]
  have key : (1 + Complex.I • chir) * (1 + Complex.I • chir)
      = (2 : ℂ) • (1 + Complex.I • chir) := by
    rw [add_mul, mul_add, mul_add, one_mul, one_mul, mul_one, h]
    module
  rw [projChirR, Matrix.smul_mul, Matrix.mul_smul, key, smul_smul, smul_smul]
  norm_num
