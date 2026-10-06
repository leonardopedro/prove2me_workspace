-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.parity_chir2_anticomm
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_chir_parity_anticomm
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : parityDiag * chir2 = -(chir2 * parityDiag) := by

  unfold parityDiag chir2
  rw [← mul_kronecker_mul, ← mul_kronecker_mul, mul_one, one_mul,
      BookProof.ChapterA3j.chir_parity_anticomm,
      ← neg_one_smul ℂ (mgamma 0 * chir), kronecker_smul]
  norm_num
