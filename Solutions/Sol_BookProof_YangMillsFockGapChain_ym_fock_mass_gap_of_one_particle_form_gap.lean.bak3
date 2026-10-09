-- Generated from ChapterYangMillsFockGapChain.lean — solution of BookProof.YangMillsFockGapChain.ym_fock_mass_gap_of_one_particle_form_gap
import Mathlib
import Definitions.Def_ChapterYangMillsFockGapChain
import Theorems.Thm_BookProof_YangMillsFockGapChain_ym_fock_gap_of_one_particle_form_gap
import Theorems.Thm_BookProof_FockSecondQuantization_toLp_zero
import Theorems.Thm_BookProof_FockSecondQuantization_ym_fock_friedrichs_extension
import Theorems.Thm_toLp_injective
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
theorem solution {mu : ℝ} (hmu : 0 < mu)
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x) :
    (∃ (Dom : Submodule ℂ Fock) (A : Dom →ₗ[ℂ] Fock),
        IsPositiveSelfAdjointExtension (dGammaOp (ymFockCol e fabc)) A) ∧
      dGamma (ymFockCol e fabc) vac = 0 ∧
      ∀ u : FockAlg, u 0 = 0 → u ≠ 0 →
        0 < (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re := by

  obtain ⟨hvac, hgapFock⟩ := ym_fock_gap_of_one_particle_form_gap e fabc hmu.le hgap
  refine ⟨ym_fock_friedrichs_extension e fabc, hvac, fun u h0 hu => ?_⟩
  have hnorm : 0 < ‖toLp u‖ := by
    have : toLp u ≠ 0 := fun hc => hu (toLp_injective (by simpa using hc))
    exact norm_pos_iff.mpr this
  have hquad := hgapFock u h0
  have hpos : 0 < mu * ‖toLp u‖ ^ 2 := by positivity
  linarith
