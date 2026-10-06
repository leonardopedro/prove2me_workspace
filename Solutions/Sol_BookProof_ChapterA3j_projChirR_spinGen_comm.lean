-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.projChirR_spinGen_comm
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3j_chir_spinGen_comm
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    projChirR * spinGen μ ν = spinGen μ ν * projChirR := by

  simp only [projChirR, Matrix.smul_mul, Matrix.mul_smul, add_mul, mul_add,
    one_mul, mul_one]
  rw [chir_spinGen_comm]
