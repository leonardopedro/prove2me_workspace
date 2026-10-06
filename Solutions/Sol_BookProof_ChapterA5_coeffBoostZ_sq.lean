-- Generated from ChapterA5.lean — solution of BookProof.ChapterA5.coeffBoostZ_sq
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) : coeffBoostZ j * coeffBoostZ j = 1 := by

  fin_cases j <;> decide
