-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.projSum
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_projChirL_add_projChirR
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : projLL + projLR + projRL + projRR = 1 := by

  -- Use the fact that `projChirL + projChirR = 1` to simplify the expression.
  have h_sum : (projChirL + projChirR) ⊗ₖ (projChirL + projChirR) = 1 := by
    rw [ BookProof.ChapterA3j.projChirL_add_projChirR ] ; aesop;
  convert h_sum using 1;
  ext; simp [ projLL, projLR, projRL, projRR ] ; ring;
