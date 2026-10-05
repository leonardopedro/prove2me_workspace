-- Generated from ChapterYangMillsFockGapChain.lean — solution of BookProof.YangMillsFockGapChain.ym_fock_gap_of_field_perturbation
import Mathlib
import Definitions.Def_ChapterYangMillsFockGapChain
import Theorems.Thm_BookProof_YangMillsFockGapChain_ym_isPosCol_shiftCol
import Theorems.Thm_BookProof_FockFieldPerturbation_fock_gap_of_field_perturbation_pos
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
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < mu) {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * l2norm f ∧
      (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := fock_gap_of_field_perturbation_pos hmu (ym_isPosCol_shiftCol e fabc hgap) hf h0
