-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_split
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.sel_split : ∀ (μ : Fin 4) (T : Finset (Fin 4)),
    sel T = sel (lo μ T) ++ sel (hi μ T) := by sorry
