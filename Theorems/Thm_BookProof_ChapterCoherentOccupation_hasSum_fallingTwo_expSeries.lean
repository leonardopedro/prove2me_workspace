-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.hasSum_fallingTwo_expSeries
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.hasSum_fallingTwo_expSeries (lam : ℝ) :
    HasSum (fun n : ℕ => (n : ℝ) * ((n : ℝ) - 1) * (lam ^ n / (n ! : ℝ)))
      (lam ^ 2 * Real.exp lam) := by sorry
