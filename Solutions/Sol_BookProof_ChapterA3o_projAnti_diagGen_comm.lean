-- Generated from ChapterA3o.lean — solution of BookProof.ChapterA3o.projAnti_diagGen_comm
import Mathlib
import Definitions.Def_ChapterA3o
import Theorems.Thm_BookProof_ChapterA3n_permMat_diagGen_comm
open BookProof.ChapterA3o



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projAnti N * diagGen A = diagGen A * projAnti N := by

  unfold projAnti
  simp only [Finset.sum_mul, Finset.mul_sum,
    smul_mul_assoc, mul_smul_comm, permMat_diagGen_comm]
