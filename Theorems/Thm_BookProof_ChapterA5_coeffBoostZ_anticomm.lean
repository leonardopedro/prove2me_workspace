-- Generated from ChapterA5.lean — theorem BookProof.ChapterA5.coeffBoostZ_anticomm
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA5
open BookProof.ChapterA5


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterA5.coeffBoostZ_anticomm {j k : Fin 3} (h : j ≠ k) :
    coeffBoostZ j * coeffBoostZ k + coeffBoostZ k * coeffBoostZ j = 0 := by sorry
