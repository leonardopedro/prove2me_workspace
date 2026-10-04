-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_hi_insert
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA4
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.sel_hi_insert : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∉ T →
    sel (hi μ (insert μ T)) = μ :: sel (hi μ T) := by sorry
