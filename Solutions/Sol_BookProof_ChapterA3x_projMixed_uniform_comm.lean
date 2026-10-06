-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_uniform_comm
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3n_projSym_uniform_comm
import Theorems.Thm_BookProof_ChapterA3o_projAnti_uniform_comm
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * uniform A = uniform A * projMixed N := by

  simp only [projMixed, sub_mul, mul_sub, one_mul, mul_one,
    projSym_uniform_comm, projAnti_uniform_comm]
