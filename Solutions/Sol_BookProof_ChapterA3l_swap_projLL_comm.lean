-- Generated from ChapterA3l.lean — solution of BookProof.ChapterA3l.swap_projLL_comm
import Mathlib
import Definitions.Def_ChapterA3l
import Theorems.Thm_BookProof_ChapterA3l_swap_kronecker
open BookProof.ChapterA3l



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k

set_option maxHeartbeats 1000000 in
theorem solution : BookProof.ChapterA3l.swap * projLL = projLL * BookProof.ChapterA3l.swap := by

  unfold projLL
  rw [swap_kronecker]
