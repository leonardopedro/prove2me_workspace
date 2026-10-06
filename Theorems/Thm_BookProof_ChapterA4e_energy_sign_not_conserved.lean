-- Generated from ChapterA4e.lean — theorem BookProof.ChapterA4e.energy_sign_not_conserved
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA5
open BookProof.ChapterA5
open BookProof.ChapterA4e


open Matrix


open BookProof.ChapterA3 BookProof.ChapterA5

theorem BookProof.ChapterA4e.energy_sign_not_conserved :
    ∃ j : Fin 3, projPos * spatialOp j ≠ spatialOp j * projPos := by sorry
