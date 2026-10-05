-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.fock_gap_of_pair_perturbation_pos
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_fock_gap_of_pair_perturbation
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f g : ℕ →₀ ℂ}
    (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) < mu) {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g) ∧
      (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re := ⟨by linarith, fock_gap_of_pair_perturbation hmu hgap hfg.le h0⟩
