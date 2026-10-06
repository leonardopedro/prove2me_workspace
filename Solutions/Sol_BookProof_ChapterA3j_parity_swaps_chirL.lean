-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.parity_swaps_chirL
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_chir_parity_anticomm
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution :
    projChirL * mgamma 0 = mgamma 0 * projChirR := by

  simp only [projChirL, projChirR, Matrix.smul_mul, Matrix.mul_smul, sub_mul,
    mul_add, one_mul, mul_one]
  rw [chir_parity_anticomm]
  module
