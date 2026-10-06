-- Generated from ChapterCoherentOccupation.lean — solution of BookProof.ChapterCoherentOccupation.coherentOccupation_eq
import Mathlib
import Definitions.Def_ChapterCoherentOccupation
open BookProof.ChapterCoherentOccupation



noncomputable section


open Real Nat ProbabilityTheory

set_option maxHeartbeats 1000000 in
theorem solution (lam : ℝ) (n : ℕ) :
    coherentOccupation lam n = Real.exp (-lam) * (lam ^ n / (n ! : ℝ)) := by

  rw [coherentOccupation, mul_div_assoc]
