-- Generated from ChapterPauliFundamental.lean — theorem BookProof.ChapterPauliFundamental.real_pauli'
import Definitions.Def_ChapterA3
import Definitions.Def_ChapterGammaCommutant
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Definitions.Def_ChapterA3b
open BookProof.ChapterPauliFundamental


open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

theorem BookProof.ChapterPauliFundamental.real_pauli_prime (α β : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ)
    (hα : IsCliffordR α) (hβ : IsCliffordR β) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, |S.det| = 1 ∧ (∀ μ, β μ = S * α μ * S⁻¹) ∧
      (∀ S' : Matrix (Fin 4) (Fin 4) ℝ, |S'.det| = 1 → (∀ μ, β μ = S' * α μ * S'⁻¹) →
        S' = S ∨ S' = -S) := by sorry
