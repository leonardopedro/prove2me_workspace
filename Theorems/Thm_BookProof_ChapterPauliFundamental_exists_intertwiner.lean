-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.exists_intertwiner
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterA3

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.exists_intertwiner (hA : IsCliffordC A) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹ := by sorry
