-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.thermalProb_mul_summable
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.thermalProb_mul_summable {nbar : ℝ} (h : 0 ≤ nbar) :
    Summable (fun n : ℕ => (n : ℝ) * thermalProb nbar n) := by sorry
