-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.fock_gap_of_pair_perturbation
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_pairVec_relative_form_bound
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_number_le_dGamma_quadForm
import Theorems.Thm_BookProof_FockNumberPreservingGap_number_quadForm_ge
open BookProof.FockPairPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability
open BookProof.FockFieldPerturbation

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu : ℝ} (hmu : 0 < mu)
    (hgap : IsPosCol (shiftCol col mu)) {f g : ℕ →₀ ℂ}
    (hfg : 2 * Real.sqrt 2 * (l2norm f * l2norm g) ≤ mu) {u : FockAlg} (h0 : u 0 = 0) :
    (mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re := by

  have hNq : 0 ≤ numberQuad u := numberQuad_nonneg u
  have hn : ‖toLp u‖ ^ 2 ≤ numberQuad u := number_quadForm_ge h0
  have hq := number_le_dGamma_quadForm hgap u
  have hqge : mu * ‖toLp u‖ ^ 2 ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
    nlinarith
  have hrel := pairVec_relative_form_bound hmu hgap f g h0
  have hlow := (abs_le.mp hrel).1
  have hvm : -((2 * Real.sqrt 2 * (l2norm f * l2norm g))
        * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re)
      ≤ (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re * mu := by
    have h := mul_le_mul_of_nonneg_right hlow hmu.le
    calc -((2 * Real.sqrt 2 * (l2norm f * l2norm g))
            * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re)
        = -((2 * Real.sqrt 2 * (l2norm f * l2norm g) / mu)
            * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re) * mu := by
          field_simp
      _ ≤ _ := h
  have hmul : ((mu - 2 * Real.sqrt 2 * (l2norm f * l2norm g)) * ‖toLp u‖ ^ 2) * mu
      ≤ ((inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re) * mu := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hqge) (sub_nonneg.mpr hfg)]
  exact le_of_mul_le_mul_right hmul hmu
