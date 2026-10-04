-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.pauli_unique
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterA3
open BookProof.ChapterPauliFundamental

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.pauli_unique {B : Fin 4 → M4} (hA : IsCliffordC A)
    (S T : M4) (hS : IsUnit S.det) (hT : IsUnit T.det)
    (hSeq : ∀ μ, B μ = S * A μ * S⁻¹) (hTeq : ∀ μ, B μ = T * A μ * T⁻¹) :
    ∃ c : ℂ, c ≠ 0 ∧ T = c • S := by sorry
