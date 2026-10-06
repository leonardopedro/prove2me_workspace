-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projSym_mul_projMixed
import Mathlib
import Definitions.Def_ChapterA3q
import Theorems.Thm_BookProof_ChapterA3n_projSym_idem
import Theorems.Thm_BookProof_ChapterA3p_projSym_mul_projAnti
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projSym N * projMixed N = 0 := by

  unfold projMixed
  simp only [mul_sub, mul_one, projSym_idem, projSym_mul_projAnti hN]
  abel
