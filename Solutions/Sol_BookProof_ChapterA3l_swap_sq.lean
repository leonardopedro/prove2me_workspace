-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.swap_sq
import Mathlib
import Definitions.Def_ChapterA3l
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : swap * swap = 1 := by

  ext ⟨i, j⟩ ⟨k, l⟩
  simp only [swap, mul_apply, of_apply, mul_ite, mul_one, mul_zero];
  rw [ Finset.sum_eq_single ( l, k ) ] <;> aesop
