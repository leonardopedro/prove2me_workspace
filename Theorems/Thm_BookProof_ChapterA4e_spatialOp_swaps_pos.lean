-- Generated from ChapterA4e.lean — theorem BookProof.ChapterA4e.spatialOp_swaps_pos
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4e
open BookProof.ChapterA4e


open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4e.spatialOp_swaps_pos (j : Fin 3) :
    projPos * spatialOp j = spatialOp j * projNeg := by sorry
