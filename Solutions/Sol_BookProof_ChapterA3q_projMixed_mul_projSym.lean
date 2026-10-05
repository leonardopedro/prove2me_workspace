-- Generated from ChapterA3q.lean — solution of BookProof.ChapterA3q.projMixed_mul_projSym
import Mathlib
import Definitions.Def_ChapterA3q
import Theorems.Thm_BookProof_ChapterA3p_projAnti_mul_projSym
open BookProof.ChapterA3q



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projSym N = 0 := by

  unfold projMixed
  simp only [sub_mul, one_mul, projSym_idem, projAnti_mul_projSym hN]
  abel
