-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_split
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by sorry
