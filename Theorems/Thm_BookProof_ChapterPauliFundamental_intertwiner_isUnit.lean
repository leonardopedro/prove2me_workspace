-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.intertwiner_isUnit
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA4
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.intertwiner_isUnit {S : M4} (hS0 : S ≠ 0) (hSint : ∀ μ, A μ * S = S * mgamma μ) :
    IsUnit S.det := by sorry
