-- Generated from ChapterFockCubicQuarticStability.lean — theorem BookProof.FockCubicQuarticStability.dGamma_multiMode_cubic_quartic_bounded_below
import Definitions.Def_ChapterFockOneParticleGap
import Definitions.Def_ChapterFockNumberPreservingGap
import Definitions.Def_ChapterFockFieldPerturbation
import Definitions.Def_ChapterFockCubicUnbounded
import Mathlib
import Definitions.Def_ChapterFockCubicQuarticStability
import Definitions.Def_ChapterFockSecondQuantization
open BookProof.FockSecondQuantization
open BookProof.FockCubicQuarticStability


noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicUnbounded

theorem BookProof.FockCubicQuarticStability.dGamma_multiMode_cubic_quartic_bounded_below (S : Finset ℕ) {col : ℕ → (ℕ →₀ ℂ)}
    {mu lam : ℝ} (hmu : 0 < mu) (hgap : IsPosCol (shiftCol col mu)) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - mu) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma col u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := by sorry
