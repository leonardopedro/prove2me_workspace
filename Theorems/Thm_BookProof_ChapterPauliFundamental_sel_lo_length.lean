-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_lo_length
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.sel_lo_length : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    (sel (lo μ T)).length = (lo μ T).card := by sorry
