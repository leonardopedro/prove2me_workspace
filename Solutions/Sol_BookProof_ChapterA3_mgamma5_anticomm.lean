-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma5_anticomm
import Mathlib
import Definitions.Def_ChapterA3
import Theorems.Thm_BookProof_ChapterA3_mgamma5Z_anticomm
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution (μ : Fin 4) :
    mgamma5 * mgamma μ + mgamma μ * mgamma5 = 0 := by

  rw [mgamma5, mgamma, ← map_mul, ← map_mul, ← map_add, mgamma5Z_anticomm, map_zero]
