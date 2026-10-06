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

theorem BookProof.ChapterH1.psi_resolvent {F : Type*} [NormedAddCommGroup F] [NormedSpace ℂ F]
    (T : F →L[ℂ] F) (X : F →L[ℂ] F) (γ z : ℂ) (v : F)
    (hTv : T v = z • v) (hz : γ - z ≠ 0)
    (_hXr : (γ • (1 : F →L[ℂ] F) - T) * X = 1)
    (hXl : X * (γ • (1 : F →L[ℂ] F) - T) = 1) :
    X v = (γ - z)⁻¹ • v := by sorry
