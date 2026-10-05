-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projMixed_mul_projAnti
import Mathlib
import Definitions.Def_ChapterA3q
import Theorems.Thm_BookProof_ChapterA3p_projSym_mul_projAnti
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projAnti N = 0 := by

  unfold projMixed
  simp only [sub_mul, one_mul, projAnti_idem, projSym_mul_projAnti hN]
  abel
