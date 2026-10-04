-- Generated from ChapterA4h.lean — theorem BookProof.ChapterA4h.prop88_energy_sign_not_conserved
import Definitions.Def_ChapterA4f
import Definitions.Def_ChapterA5
import Mathlib
import Definitions.Def_ChapterA4h
import Definitions.Def_ChapterA4e
import Definitions.Def_ChapterA4
open BookProof.ChapterA4e
open BookProof.ChapterA4h

variable (R : Type*)


open Matrix


open BookProof.ChapterA4e BookProof.ChapterA4f BookProof.ChapterA5

theorem BookProof.ChapterA4h.prop88_energy_sign_not_conserved :
    ¬ ∀ j : Fin 3, projPos * spatialOp j = spatialOp j * projPos := by sorry
