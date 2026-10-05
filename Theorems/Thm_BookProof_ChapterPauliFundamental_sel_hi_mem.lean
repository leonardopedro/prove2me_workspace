-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_hi_mem
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.sel_hi_mem : ∀ (μ : Fin 4) (T : Finset (Fin 4)), μ ∈ T →
    sel (hi μ T) = μ :: sel (hi μ (T.erase μ)) := by sorry
