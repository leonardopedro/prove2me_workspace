-- Generated from ChapterFockPairPerturbation.lean — theorem BookProof.FockPairPerturbation.fock_gap_of_pair_perturbation_pos
import Definitions.Def_ChapterFockOneParticleGap
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Definitions.Def_ChapterFockSecondQuantization
import Definitions.Def_ChapterA4
open BookProof.FockSecondQuantization
open BookProof.FockPairPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockFieldPerturbation

theorem BookProof.FockPairPerturbation.fock_gap_of_pair_perturbation_pos {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f g : ℕ →₀ ℂ}
    (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) < mu) {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g) ∧
      (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re := by sorry
