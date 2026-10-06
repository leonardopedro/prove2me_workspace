-- Generated from ChapterA3j.lean — solution of BookProof.ChapterA3j.chir_sq
import Mathlib
import Definitions.Def_ChapterA3j
import Theorems.Thm_BookProof_ChapterA3_mgamma5_sq
open BookProof.ChapterA3j



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution : chir * chir = -1 := by

  rw [chir, mgamma5_sq]
