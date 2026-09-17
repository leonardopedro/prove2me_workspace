-- Generated from ChapterHashimotoShiftInvert.lean — theorem BookProof.HashimotoShiftInvert.shiftRange_isClosed
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert



open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

theorem BookProof.HashimotoShiftInvert.shiftRange_isClosed {A : Dom →ₗ[ℂ] F} (hsym : SymmetricOn Dom A)
    (hpos : ∀ x : Dom, 0 ≤ quadForm A x)
    (hsa : ∀ w u : F, (∀ v : Dom, (inner ℂ (A v) w : ℂ) = inner ℂ (v : F) u) →
      ∃ h : w ∈ Dom, A ⟨w, h⟩ = u)
    {γ : ℝ} (hγ : 0 < γ) : IsClosed ((shiftRange A γ : Submodule ℂ F) : Set F) := by sorry
