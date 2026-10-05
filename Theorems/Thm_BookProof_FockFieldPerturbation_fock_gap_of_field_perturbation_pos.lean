-- Generated from ChapterFockFieldPerturbation.lean — theorem BookProof.FockFieldPerturbation.fock_gap_of_field_perturbation_pos
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockInteractionStability
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockFieldPerturbation


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

theorem BookProof.FockFieldPerturbation.fock_gap_of_field_perturbation_pos {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * l2norm f ∧
      (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by sorry
