-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.intertwiner_isUnit
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.intertwiner_isUnit {S : M4} (hS0 : S ≠ 0) (hSint : ∀ μ, A μ * S = S * mgamma μ) :
    IsUnit S.det := by sorry
