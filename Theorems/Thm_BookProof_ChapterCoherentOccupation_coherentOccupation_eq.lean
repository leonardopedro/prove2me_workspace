-- Generated from ChapterCoherentOccupation.lean — theorem BookProof.ChapterCoherentOccupation.coherentOccupation_eq
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation


noncomputable section


open Real Nat ProbabilityTheory

theorem BookProof.ChapterCoherentOccupation.coherentOccupation_eq (lam : ℝ) (n : ℕ) :
    coherentOccupation lam n = Real.exp (-lam) * (lam ^ n / (n ! : ℝ)) := by sorry
