-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma5_sq
import Mathlib
import Definitions.Def_ChapterA3
import Theorems.Thm_BookProof_ChapterA3_mgamma5Z_sq
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    mgamma5 * mgamma5 = -(1 : Matrix (Fin 4) (Fin 4) ℂ) := by

  rw [mgamma5, ← map_mul, mgamma5Z_sq, map_neg, map_one]
