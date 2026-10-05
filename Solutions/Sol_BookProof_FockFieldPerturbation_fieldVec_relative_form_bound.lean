-- Generated from ChapterFockFieldPerturbation.lean — solution of BookProof.FockFieldPerturbation.fieldVec_relative_form_bound
import Mathlib
import Definitions.Def_ChapterFockFieldPerturbation
import Theorems.Thm_BookProof_FockFieldPerturbation_numberQuad_nonneg
import Theorems.Thm_BookProof_FockFieldPerturbation_abs_re_inner_fieldVec_le
import Theorems.Thm_BookProof_FockFieldPerturbation_two_mul_sqrt_le
import Theorems.Thm_BookProof_FockFieldPerturbation_number_le_dGamma_quadForm
open BookProof.FockFieldPerturbation



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockInteractionStability

set_option maxHeartbeats 1000000 in
theorem solution {col : ℕ → (ℕ →₀ ℂ)} {mu t : ℝ} (hmu : 0 < mu)
    (ht : 0 < t) (hgap : IsPosCol (shiftCol col mu)) (f : ℕ →₀ ℂ) (u : FockAlg) :
    |(inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re|
      ≤ t / mu * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + l2norm f ^ 2 / t * ‖toLp u‖ ^ 2 := by

  have h1 := abs_re_inner_fieldVec_le f u
  have h2 := two_mul_sqrt_le (c := l2norm f) (n := ‖toLp u‖) (N := numberQuad u) (t := t)
    (numberQuad_nonneg u) ht
  have h3 := number_le_dGamma_quadForm hgap u
  have h4 : t * numberQuad u
      ≤ t / mu * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by
    rw [div_mul_eq_mul_div, le_div_iff₀ hmu]
    nlinarith [ht.le]
  linarith
