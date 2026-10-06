-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherentOccupation_variance
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherentOccupation_variance (lam : ℝ) :
    (∑' n : ℕ, (n : ℝ) ^ 2 * coherentOccupation lam n)
      - (∑' n : ℕ, (n : ℝ) * coherentOccupation lam n) ^ 2 = lam := by sorry
