-- Generated from ChapterA3o.lean — solution of BookProof.ChapterA3o.projAnti_idem
import Mathlib
import Definitions.Def_ChapterA3o
import Theorems.Thm_BookProof_ChapterA3o_sum_signed_permMat_sq
open BookProof.ChapterA3o



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} : projAnti N * projAnti N = projAnti N := by

  have h : (Nat.factorial N : ℂ) ≠ 0 := Nat.cast_ne_zero.mpr (Nat.factorial_ne_zero N)
  unfold projAnti
  rw [Matrix.smul_mul, Matrix.mul_smul, sum_signed_permMat_sq, smul_smul, smul_smul,
    mul_assoc, inv_mul_cancel₀ h, mul_one]
