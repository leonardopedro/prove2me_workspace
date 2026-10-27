-- Generated from ChapterFockPairPerturbation.lean — solution of BookProof.FockPairPerturbation.pairVec_relative_form_bound
import Mathlib
import Definitions.Def_ChapterFockPairPerturbation
import Theorems.Thm_BookProof_FockPairPerturbation_abs_re_inner_pairVec_le
import Theorems.Thm_BookProof_FockFieldPerturbation_l2norm_nonneg
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
    (hgap : IsPosCol (shiftCol col mu)) (f g : ℕ →₀ ℂ) {u : FockAlg} (h0 : u 0 = 0) :
    |(inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re|
      ≤ (2 * Real.sqrt 2 * (l2norm f * l2norm g) / mu)
          * (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re := by

  have hNq : 0 ≤ numberQuad u := numberQuad_nonneg u
  have hn : ‖toLp u‖ ^ 2 ≤ numberQuad u := number_quadForm_ge h0
  have hcf : 0 ≤ l2norm f := l2norm_nonneg f
  have hcg : 0 ≤ l2norm g := l2norm_nonneg g
  have hq := number_le_dGamma_quadForm hgap u
  have hsqrt2 : Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)
      ≤ Real.sqrt 2 * Real.sqrt (numberQuad u) := by
    rw [← Real.sqrt_mul (by norm_num : (0 : ℝ) ≤ 2)]
    exact Real.sqrt_le_sqrt (by linarith)
  have hprod : Real.sqrt (numberQuad u) * Real.sqrt (numberQuad u + ‖toLp u‖ ^ 2)
      ≤ Real.sqrt 2 * numberQuad u := by
    have hs : Real.sqrt (numberQuad u) ^ 2 = numberQuad u := Real.sq_sqrt hNq
    have h := mul_le_mul_of_nonneg_left hsqrt2 (Real.sqrt_nonneg (numberQuad u))
    nlinarith [Real.sqrt_nonneg (numberQuad u), Real.sqrt_nonneg 2]
  have hbound := abs_re_inner_pairVec_le f g u
  have hstep : |(inner ℂ (toLp u) (toLp (pairVec f g u)) : ℂ).re|
      ≤ 2 * Real.sqrt 2 * (l2norm f * l2norm g) * numberQuad u := by
    have hc : 0 ≤ 2 * (l2norm f * l2norm g) := by
      have := mul_nonneg (l2norm_nonneg f) (l2norm_nonneg g); linarith
    nlinarith [mul_le_mul_of_nonneg_left hprod hc]
  rw [div_mul_eq_mul_div, le_div_iff₀ hmu]
  have hc2 : 0 ≤ 2 * Real.sqrt 2 * (l2norm f * l2norm g) :=
    mul_nonneg (by positivity) (mul_nonneg hcf hcg)
  nlinarith [mul_le_mul_of_nonneg_left hq hc2, mul_le_mul_of_nonneg_right hstep hmu.le]
