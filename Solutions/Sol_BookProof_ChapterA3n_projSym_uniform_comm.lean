-- Generated from ChapterA3n.lean — solution of BookProof.ChapterA3n.projSym_uniform_comm
import Mathlib
import Definitions.Def_ChapterA3n
import Theorems.Thm_BookProof_ChapterA3n_permMat_uniform_comm
open BookProof.ChapterA3n



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (A : Matrix (Fin 4) (Fin 4) ℂ) :
    projSym N * uniform A = uniform A * projSym N := by

  unfold projSym;
  simp only [smul_mul_assoc, mul_smul_comm];
  simp only [Finset.sum_mul, permMat_uniform_comm, Finset.mul_sum _ _ _]
