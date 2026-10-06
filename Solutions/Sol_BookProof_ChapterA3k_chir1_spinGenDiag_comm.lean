-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.chir1_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_chir_spinGen_comm
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    chir1 * spinGenDiag μ ν = spinGenDiag μ ν * chir1 := by

      unfold spinGenDiag chir1;
      simp only [mul_add, add_mul, ← mul_kronecker_mul];
      simp [ BookProof.ChapterA3j.chir_spinGen_comm ]
