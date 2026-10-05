-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projMixed_uniform_comm
import Mathlib
import Definitions.Def_ChapterA3q
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projMixed N * uniform A = uniform A * projMixed N := by

  unfold projMixed
  simp only [sub_mul, mul_sub, one_mul, mul_one,
    projSym_uniform_comm, projAnti_uniform_comm]
