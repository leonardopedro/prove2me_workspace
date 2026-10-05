-- Generated from ChapterA3m.lean — solution of BookProof.ChapterA3m.braid_rel
import Mathlib
import Definitions.Def_ChapterA3m
import Theorems.Thm_BookProof_ChapterA3m_braid_left
import Theorems.Thm_BookProof_ChapterA3m_braid_right
open BookProof.ChapterA3m



open Matrix
open scoped Kronecker


open BookProof.ChapterA3 BookProof.ChapterA3j BookProof.ChapterA3k BookProof.ChapterA3l

set_option maxHeartbeats 1000000 in
theorem solution : swap12 * swap23 * swap12 = swap23 * swap12 * swap23 := by

  rw [braid_left, braid_right]
