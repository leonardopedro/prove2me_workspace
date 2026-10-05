-- Generated from ChapterA4h.lean — solution of BookProof.ChapterA4h.cor1_energy_sectors_swapped
import Mathlib
import Definitions.Def_ChapterA4h
open BookProof.ChapterA4h



open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

variable (R : Type*)

set_option maxHeartbeats 1000000 in
theorem solution (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg := spatialOp_swaps_pos j
