-- Generated from ChapterFockCubicQuarticStability.lean — solution of BookProof.FockCubicQuarticStability.dGamma_multiMode_cubic_quartic_bounded_below
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Theorems.Thm_BookProof_FockCubicQuarticStability_multiMode_cubic_quartic_bounded_below
import Theorems.Thm_BookProof_FockFieldPerturbation_number_le_dGamma_quadForm
open BookProof.FockCubicQuarticStability



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

set_option maxHeartbeats 1000000 in
theorem solution (S : Finset ℕ) {col : ℕ → (ℕ →₀ ℂ)}
    {mu lam : ℝ} (hmu : 0 < mu) (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by

  have hbase := multiMode_cubic_quartic_bounded_below S (mu := mu) (lam := lam) hmu.le u
  have hfree : mu * numberQuad u ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re :=
    number_le_dGamma_quadForm hgap u
  linarith
