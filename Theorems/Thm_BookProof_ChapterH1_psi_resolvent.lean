-- Generated from ChapterH1.lean — theorem BookProof.ChapterH1.psi_resolvent
import Mathlib
import Definitions.Def_ChapterH1
import Definitions.Def_ChapterGhostField
open BookProof.GhostField
open BookProof.ChapterH1

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]


open scoped BigOperators
open intervalIntegral


noncomputable section

theorem BookProof.ChapterH1.psi_resolvent (k : ℕ) (γ z : ℂ) (_hz : γ - z ≠ 0) :
    psi k γ (γ - z)⁻¹ = phi k z := by sorry
