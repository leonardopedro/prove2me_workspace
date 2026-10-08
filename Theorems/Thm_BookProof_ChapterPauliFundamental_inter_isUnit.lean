-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.inter_isUnit
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.inter_isUnit (hA : IsCliffordC A) {F : M4} (hF : inter A F ≠ 0) :
    IsUnit (inter A F).det := by sorry
