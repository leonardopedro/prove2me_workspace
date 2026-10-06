-- Generated from ChapterA3k.lean — solution of BookProof.ChapterA3k.parity_swaps_RR_LL
import Mathlib
import Definitions.Def_ChapterA3k
import Theorems.Thm_BookProof_ChapterA3j_parity_swaps_chirR
open BookProof.ChapterA3k



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j

set_option maxHeartbeats 1000000 in
theorem solution : parityDiag * projLL = projRR * parityDiag := by

  simp only [parityDiag, Fin.isValue, projLL, ← mul_kronecker_mul, projRR]
  rw [BookProof.ChapterA3j.parity_swaps_chirR]
