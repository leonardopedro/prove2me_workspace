-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.clifford_key
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.clifford_key (hA : IsCliffordC A) (μ : Fin 4) (T : Finset (Fin 4)) :
    A μ * gpF A T = sgnT μ T • gpF A (stepT μ T) := by sorry
