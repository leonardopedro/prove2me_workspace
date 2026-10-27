-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.fock_gap_of_one_particle_form_gap_pair
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_fock_gap_of_pair_perturbation
import Theorems.Thm_BookProof_YangMillsFockGapChain_isPosCol_shiftCol_opCol_of_form_gap
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F)
    (A : finiteModeDomain b →ₗ[ℂ] finiteModeDomain b) {mu : ℝ} (hmu : 0 < mu)
    (hform : ∀ x : finiteModeDomain b,
      mu * ‖(x : F)‖ ^ 2 ≤ quadForm ((finiteModeDomain b).subtype.comp A) x)
    {f g : ℕ →₀ ℂ} (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) ≤ mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b A) u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re :=
  fock_gap_of_pair_perturbation hmu
      (BookProof.YangMillsFockGapChain.isPosCol_shiftCol_opCol_of_form_gap b A hform) hfg h0
