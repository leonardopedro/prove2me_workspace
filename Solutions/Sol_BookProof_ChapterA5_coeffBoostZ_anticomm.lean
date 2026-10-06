-- Generated from ChapterA5.lean — solution of BookProof.ChapterA5.coeffBoostZ_anticomm
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5



open Matrix


open BookProof.ChapterA3

set_option maxHeartbeats 1000000 in
theorem solution {j k : Fin 3} (h : j ≠ k) :
    coeffBoostZ j * coeffBoostZ k + coeffBoostZ k * coeffBoostZ j = 0 := by

  fin_cases j <;> fin_cases k <;> first | (exact absurd rfl h) | decide
