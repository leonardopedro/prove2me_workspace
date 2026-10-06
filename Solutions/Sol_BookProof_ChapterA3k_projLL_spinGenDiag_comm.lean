-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.projLL_spinGenDiag_comm
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_projChirL_spinGen_comm
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution (μ ν : Fin 4) :
    projLL * spinGenDiag μ ν = spinGenDiag μ ν * projLL := by

      unfold projLL spinGenDiag;
      simp only [mul_add, ← mul_kronecker_mul, add_mul];
      rw [ BookProof.ChapterA3j.projChirL_spinGen_comm ];
      norm_num
