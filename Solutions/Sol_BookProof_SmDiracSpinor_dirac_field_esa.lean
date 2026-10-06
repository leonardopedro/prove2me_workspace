-- Generated from ChapterSmDiracSpinor.lean — solution of BookProof.SmDiracSpinor.dirac_field_esa
import Mathlib
import Definitions.Def_ChapterSmDiracSpinor
import Theorems.Thm_BookProof_SmDiracSpinor_diracOneParticle_hermitian
open BookProof.SmDiracSpinor




open Matrix
open BookProof.ChapterCPTHamiltonian BookProof.SmCar BookProof.SmDiracYukawa
open BookProof.FarisLavine

noncomputable section

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

variable {k : Fin 3 → ℝ} {m1 m2 : ℝ}

set_option maxHeartbeats 1000000 in
theorem solution {om : Fin 4 → ℝ} {c0 : ℝ} (hom : ∀ i, 0 ≤ om i) (hc0 : 1 ≤ c0) :
    EssentiallySelfAdjointOn (fullDom 4)
      ((onFull (smFermiHam (diracOneParticle k m1 m2) (0 : Matrix (Fin 4) (Fin 4) ℂ) 0)).comp
        (Submodule.inclusion (le_refl (fullDom 4)))) := sm_fermi_esa (om := om) (c0 := c0) diracOneParticle_hermitian hom hc0
