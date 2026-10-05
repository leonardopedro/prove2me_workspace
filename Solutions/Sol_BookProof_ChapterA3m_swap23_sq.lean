-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.swap23_sq
import Mathlib
import Definitions.Def_ChapterA3m
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution : swap23 * swap23 = 1 := by

  ext a b;
  rw [ Matrix.mul_apply ];
  simp only [swap23, of_apply, mul_ite, mul_one, mul_zero, one_apply];
  rw [ Finset.sum_eq_single ( ( b.1.1, b.2 ), b.1.2 ) ] <;> aesop
