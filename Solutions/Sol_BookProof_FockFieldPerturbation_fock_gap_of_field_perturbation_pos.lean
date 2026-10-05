-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.fock_gap_of_field_perturbation_pos
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_fock_gap_of_field_perturbation
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    0 < mu - 2 * l2norm f ∧
      (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by

  refine ⟨by linarith, fock_gap_of_field_perturbation hmu hgap ?_ h0⟩
  have := l2norm_nonneg f
  linarith
