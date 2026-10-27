-- Generated from ChapterPauliFundamental.lean — solution of BookProof.ChapterPauliFundamental.real_pauli'
import Mathlib
import Definitions.Def_ChapterPauliFundamental
import Theorems.Thm_BookProof_ChapterPauliFundamental_pauliFundamental
import Theorems.Thm_BookProof_ChapterA3_real_pauli
open BookProof.ChapterPauliFundamental



open Matrix Finset


open BookProof.ChapterA3 BookProof.ChapterGammaCommutant

variable {A : Fin 4 → M4}

set_option maxHeartbeats 1000000 in
theorem solution (α β : Fin 4 → Matrix (Fin 4) (Fin 4) ℝ)
    (hα : IsCliffordR α) (hβ : IsCliffordR β) :
    ∃ S : Matrix (Fin 4) (Fin 4) ℝ, |S.det| = 1 ∧ (∀ μ, β μ = S * α μ * S⁻¹) ∧
      (∀ S' : Matrix (Fin 4) (Fin 4) ℝ, |S'.det| = 1 → (∀ μ, β μ = S' * α μ * S'⁻¹) →
        S' = S ∨ S' = -S) := real_pauli pauliFundamental α β hα hβ
