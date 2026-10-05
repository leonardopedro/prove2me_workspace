-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.sel_lo_ne
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.sel_lo_ne : ∀ (μ : Fin 4) (T : Finset (Fin 4)), ∀ ν ∈ sel (lo μ T), ν ≠ μ := by sorry
