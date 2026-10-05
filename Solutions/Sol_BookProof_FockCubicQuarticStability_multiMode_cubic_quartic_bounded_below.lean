-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.multiMode_cubic_quartic_bounded_below
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_mode_cubic_quartic_bounded_below
import Theorems.Thm_BookProof_FockFieldPerturbation_sum_sq_annA_le
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset ℕ) {mu lam : ℝ} (hmu : 0 ≤ mu)
    (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ mu * numberQuad u
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by

  classical
  set K := 2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2 with hKdef
  have hterm : ∀ k ∈ S, -(K * ‖toLp u‖ ^ 2) ≤
      mu * ‖toLp (annA k u)‖ ^ 2
        + (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by
    intro k _
    have h := mode_cubic_quartic_bounded_below k mu lam u
    rw [hKdef]
    linarith
  have hsum : ∑ _k ∈ S, -(K * ‖toLp u‖ ^ 2)
      ≤ ∑ k ∈ S, (mu * ‖toLp (annA k u)‖ ^ 2
        + (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re)) :=
    Finset.sum_le_sum hterm
  rw [Finset.sum_const, nsmul_eq_mul] at hsum
  rw [Finset.sum_add_distrib, ← Finset.mul_sum] at hsum
  rw [hKdef] at hsum
  have hocc : ∑ k ∈ S, ‖toLp (annA k u)‖ ^ 2 ≤ numberQuad u := sum_sq_annA_le u S
  have hmul := mul_le_mul_of_nonneg_left hocc hmu
  rw [hKdef]
  linarith
