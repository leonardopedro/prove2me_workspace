-- Generated from ChapterA4h.lean — theorem BookProof.ChapterA4h.cor1_energy_sectors_swapped
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4h
import Definitions.Def_ChapterA4e
open BookProof.ChapterA4e
open BookProof.ChapterA4h

variable (R : Type*)


open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

theorem BookProof.ChapterA4h.cor1_energy_sectors_swapped (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg := by sorry
