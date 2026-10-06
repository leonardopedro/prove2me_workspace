-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.swap_chir2
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_kronecker
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : swap * chir2 = chir1 * swap := by

  unfold chir1 chir2
  rw [swap_kronecker]
