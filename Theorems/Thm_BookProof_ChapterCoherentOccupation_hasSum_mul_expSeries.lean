-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.hasSum_mul_expSeries
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.hasSum_mul_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * (lam ^ n / (n ! : ℝ))) (lam * Real.exp lam) := by sorry
