-- Generated from ChapterA3x.lean — solution of BookProof.ChapterA3x.projMixed_idem
import Mathlib
import Definitions.Def_ChapterA3x
import Theorems.Thm_BookProof_ChapterA3x_projMixed_mul_projSym
import Theorems.Thm_BookProof_ChapterA3x_projMixed_mul_projAnti
open BookProof.ChapterA3x



open Matrix
open scoped BigOperators


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3n BookProof.ChapterA3o
open BookProof.ChapterA3p

set_option maxHeartbeats 1000000 in
theorem solution {N : ℕ} (hN : 2 ≤ N) :
    projMixed N * projMixed N = projMixed N := by

  conv_lhs => rw [show projMixed N * projMixed N
      = projMixed N * 1 - projMixed N * projSym N - projMixed N * projAnti N by
    simp only [projMixed, mul_sub, mul_one]]
  rw [projMixed_mul_projSym hN, projMixed_mul_projAnti hN, mul_one]
  abel
