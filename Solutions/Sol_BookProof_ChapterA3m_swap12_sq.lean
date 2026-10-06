-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.swap12_sq
import Mathlib
import Definitions.Def_ChapterA3m
import Theorems.Thm_BookProof_ChapterA3l_swap_sq
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution : swap12 * swap12 = 1 := by

  have h_swap12_sq : swap12 * swap12 = (swap ⊗ₖ 1) * (swap ⊗ₖ 1) := by
    rfl;
  rw [ h_swap12_sq, ← Matrix.mul_kronecker_mul ];
  rw [ BookProof.ChapterA3l.swap_sq ] ; norm_num
