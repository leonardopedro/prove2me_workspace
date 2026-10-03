-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.pauli_exists
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterA3b
import Definitions.Def_ChapterA4
open BookProof.ChapterA3

variable {A : Fin 4 → M4}


open Matrix Finset



theorem BookProof.ChapterPauliFundamental.pauli_exists {B : Fin 4 → M4} (hA : IsCliffordC A) (hB : IsCliffordC B) :
    ∃ S : M4, IsUnit S.det ∧ ∀ μ, B μ = S * A μ * S⁻¹ := by sorry
