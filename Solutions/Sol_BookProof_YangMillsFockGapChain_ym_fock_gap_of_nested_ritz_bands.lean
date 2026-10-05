-- Generated from ChapterYangMillsFockGapChain.lean — solution of BookProof.YangMillsFockGapChain.ym_fock_gap_of_nested_ritz_bands
import Mathlib
import Definitions.Def_ChapterYangMillsFockGapChain
import Theorems.Thm_BookProof_YangMillsFockGapChain_ym_fock_gap_of_one_particle_form_gap
import Theorems.Thm_BookProof_BandEnclosure_friedrichs_form_gap_of_nested_ritz_bands
import Theorems.Thm_BookProof_BandEnclosure_quadForm_ge_of_le_ritzInf
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_quadForm_nonneg
import Theorems.Thm_BookProof_YangMillsHermite_ymHamiltonian_symmetricOn
open BookProof.YangMillsFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation
open BookProof.FarisLavine BookProof.HermiteGalerkin
open BookProof.YangMillsHermite BookProof.HermiteProductCore
open BookProof.YangMillsFriedrichs BookProof.BandEnclosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {mu : ℝ} (hmu : 0 ≤ mu)
    {lo hi : ℕ → ℝ} (hnest : NestedBands lo hi)
    (hritz : ∀ m, ritzInf (ymHamiltonian (coreRepBasis e) fabc)
      (galerkinSpan (coreBasis e) (m + 1)) ∈ Set.Icc (lo m) (hi m))
    {m₀ : ℕ} (hlo : mu ≤ lo m₀) :
    (∀ m, ritzInf (ymHamiltonian (coreRepBasis e) fabc)
        (finiteModeDomain (coreBasis e)) ∈ Set.Icc (lo m) (hi m)) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 →
        mu * ‖toLp u‖ ^ 2
          ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by

  obtain ⟨hband, hmuInf, -⟩ := friedrichs_form_gap_of_nested_ritz_bands (coreBasis e)
    (ymHamiltonian (coreRepBasis e) fabc)
    (ymHamiltonian_symmetricOn (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hnest hritz hlo
  have hgap := quadForm_ge_of_le_ritzInf (ymHamiltonian (coreRepBasis e) fabc)
    (ymHamiltonian_quadForm_nonneg (coreRepBasis e) fabc) hmuInf
  obtain ⟨hvac, hfock⟩ := ym_fock_gap_of_one_particle_form_gap e fabc hmu hgap
  exact ⟨hband, hvac, hfock⟩
