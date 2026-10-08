-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.exists_intertwiner
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.exists_intertwiner (hA : IsCliffordC A) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, A μ = S * mgamma μ * S⁻¹ := by sorry
