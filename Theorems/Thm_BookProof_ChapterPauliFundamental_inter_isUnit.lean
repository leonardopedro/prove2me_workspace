-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.inter_isUnit
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.inter_isUnit (hA : IsCliffordC A) {F : M4} (hF : inter A F ≠ 0) :
    IsUnit (inter A F).det := by sorry
