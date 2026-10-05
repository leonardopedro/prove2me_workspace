-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.G_eq_map
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.G_eq_map (T : Finset (Fin 4)) : G T = (GZ T).map (Int.cast) := by sorry
