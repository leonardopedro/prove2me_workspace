-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.G_isUnit
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.G_isUnit (T : Finset (Fin 4)) : IsUnit (G T).det := by sorry
