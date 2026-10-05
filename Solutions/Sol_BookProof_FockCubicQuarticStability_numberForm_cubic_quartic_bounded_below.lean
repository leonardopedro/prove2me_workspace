-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.numberForm_cubic_quartic_bounded_below
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_sq_norm_annA_le_numberQuad
import Theorems.Thm_BookProof_FockCubicQuarticStability_mode_cubic_quartic_bounded_below
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) {mu lam : ℝ} (hmu : 0 ≤ mu)
    (u : FockAlg) :
    -(2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by

  have hmode := mode_cubic_quartic_bounded_below k mu lam u
  have hnq := mul_le_mul_of_nonneg_left (sq_norm_annA_le_numberQuad k u) hmu
  linarith
