-- Generated from ChapterH1.lean — solution of BookProof.ChapterH1.psi_resolvent
import Mathlib
import Definitions.Def_ChapterH1
open BookProof.ChapterH1







open scoped BigOperators
open intervalIntegral


noncomputable section














variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

set_option maxHeartbeats 1000000 in
theorem solution (k : ℕ) (γ z : ℂ) (_hz : γ - z ≠ 0) :
    psi k γ (γ - z)⁻¹ = phi k z := by

  unfold psi; aesop;
