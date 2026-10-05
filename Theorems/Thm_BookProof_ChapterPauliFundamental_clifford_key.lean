-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.clifford_key
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by sorry
