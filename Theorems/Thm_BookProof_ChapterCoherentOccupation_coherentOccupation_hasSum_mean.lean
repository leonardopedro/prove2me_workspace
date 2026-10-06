-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherentOccupation_hasSum_mean
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherentOccupation_hasSum_mean (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * coherentOccupation lam n) lam := by sorry
