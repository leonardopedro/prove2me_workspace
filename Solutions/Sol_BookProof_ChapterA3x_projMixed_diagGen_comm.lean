-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_diagGen_comm
import Mathlib
import Definitions.Def_ChapterA3x
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * diagGen A = diagGen A * projMixed N := by

  simp only [projMixed, sub_mul, mul_sub, one_mul, mul_one,
    projSym_diagGen_comm, projAnti_diagGen_comm]
