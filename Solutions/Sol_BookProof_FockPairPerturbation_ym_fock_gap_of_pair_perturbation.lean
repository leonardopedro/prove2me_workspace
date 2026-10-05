-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.ym_fock_gap_of_pair_perturbation
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_fock_gap_of_pair_perturbation_pos
import Theorems.Thm_BookProof_YangMillsFockGapChain_ym_isPosCol_shiftCol
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable (e : ℕ ≃ (Fin 99 →₀ ℕ)) (fabc : Fin 8 → Fin 8 → Fin 8 → ℝ)

set_option maxHeartbeats 1000000 in
theorem solution {mu : ℝ} (hmu : 0 < mu)
    (hgap : ∀ x : finiteModeDomain (coreBasis e),
      mu * ‖(x : L2d 99)‖ ^ 2 ≤ quadForm (ymHamiltonian (coreRepBasis e) fabc) x)
    {f g : ℕ →₀ ℂ} (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) < mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g) ∧
      (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma (ymFockCol e fabc) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re := fock_gap_of_pair_perturbation_pos hmu (ym_isPosCol_shiftCol e fabc hgap) hfg h0
