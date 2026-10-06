-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.parity_swaps_LL_RR
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_parity_swaps_chirL
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : parityDiag * projRR = projLL * parityDiag := by

  simp only [parityDiag, Fin.isValue, projRR, ← mul_kronecker_mul, projLL];
  rw [ BookProof.ChapterA3j.parity_swaps_chirL ]
