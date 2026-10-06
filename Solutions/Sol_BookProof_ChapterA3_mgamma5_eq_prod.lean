-- Generated from ChapterA3.lean — solution of BookProof.ChapterA3.mgamma5_eq_prod
import Mathlib
import Definitions.Def_ChapterA3
import Theorems.Thm_BookProof_ChapterA3_mgamma5Z_eq_prod
open BookProof.ChapterA3



open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    mgamma5 = mgamma 0 * mgamma 1 * mgamma 2 * mgamma 3 := by

  rw [mgamma5, mgamma, mgamma, mgamma, mgamma, mgamma5Z_eq_prod, map_mul, map_mul, map_mul]
