-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.hasSum_expSeries
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.hasSum_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => lam ^ n / (n ! : ℝ)) (Real.exp lam) := by sorry
