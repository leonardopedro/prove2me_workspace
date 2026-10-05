-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.fock_gap_of_field_perturbation
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_abs_re_inner_fieldVec_le
import Theorems.Thm_BookProof_FockFieldPerturbation_number_le_dGamma_quadForm
import Theorems.Thm_BookProof_FockNumberPreservingGap_number_quadForm_ge
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f : ℕ →₀ ℂ} (hf : l2norm f ≤ mu)
    {u : FockAlg} (h0 : u 0 = 0) :
    (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := by

  have hc : 0 ≤ l2norm f := l2norm_nonneg f
  have hn : 0 ≤ ‖toLp u‖ := norm_nonneg _
  have hNq : 0 ≤ numberQuad u := numberQuad_nonneg u
  have hD := number_le_dGamma_quadForm hgap u
  have hnum : ‖toLp u‖ ^ 2 ≤ numberQuad u := number_quadForm_ge h0
  have hPhi := (abs_le.mp (abs_re_inner_fieldVec_le f u)).1
  have hs : Real.sqrt (numberQuad u) ^ 2 = numberQuad u := Real.sq_sqrt hNq
  have hs0 : 0 ≤ Real.sqrt (numberQuad u) := Real.sqrt_nonneg _
  have hsn : ‖toLp u‖ ≤ Real.sqrt (numberQuad u) := by nlinarith
  have hkey : (mu - 2 * l2norm f) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u - 2 * l2norm f * Real.sqrt (numberQuad u) * ‖toLp u‖ := by
    have hfac : 0 ≤ (Real.sqrt (numberQuad u) - ‖toLp u‖) *
        (mu * (Real.sqrt (numberQuad u) + ‖toLp u‖) - 2 * l2norm f * ‖toLp u‖) := by
      have h1 : 0 ≤ Real.sqrt (numberQuad u) - ‖toLp u‖ := by linarith
      have h2 : 0 ≤ mu * (Real.sqrt (numberQuad u) + ‖toLp u‖) - 2 * l2norm f * ‖toLp u‖ := by
        nlinarith
      exact mul_nonneg h1 h2
    nlinarith
  linarith
