-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherentOccupation_hasSum_second_moment
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherentOccupation_hasSum_second_moment (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) ^ 2 * coherentOccupation lam n) (lam ^ 2 + lam) := by sorry
