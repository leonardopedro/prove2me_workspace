-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.trial_cubic_quartic_bounded_below_general
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_numberForm_cubic_quartic_bounded_below
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (lam : ℝ) (u : FockAlg) :
    -(2 * lam ^ 4 + lam ^ 2 + 1 / 8) * ‖toLp u‖ ^ 2
      ≤ numberQuad u
        + lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
        + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re := by

  have h := numberForm_cubic_quartic_bounded_below k (mu := 1) (lam := lam) zero_le_one u
  have hconst : (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - 1) ^ 2 / 2)
      = 2 * lam ^ 4 + lam ^ 2 + 1 / 8 := by ring
  rw [hconst] at h
  simpa using h
