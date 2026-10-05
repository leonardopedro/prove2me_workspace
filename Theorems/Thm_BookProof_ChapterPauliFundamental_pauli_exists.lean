-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.pauli_exists
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

theorem BookProof.ChapterPauliFundamental.pauli_exists {B : Fin 4 → M4} (hA : IsCliffordC A) (hB : IsCliffordC B) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, B μ = S * A μ * S⁻¹ := by sorry
