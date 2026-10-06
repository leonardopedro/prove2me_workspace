-- Generated from ChapterA5.lean — solution of BookProof.ChapterA5.coeffBoostZ_mass2_anticomm
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    coeffBoostZ j * coeffMass2Z + coeffMass2Z * coeffBoostZ j = 0 := by

  fin_cases j <;> decide
