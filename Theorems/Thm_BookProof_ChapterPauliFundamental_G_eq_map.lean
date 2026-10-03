-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.G_eq_map
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA4
open BookProof.ChapterA3

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.G_eq_map (T : Finset (Fin 4)) : G T = (GZ T).map (Int.cast) := by sorry
