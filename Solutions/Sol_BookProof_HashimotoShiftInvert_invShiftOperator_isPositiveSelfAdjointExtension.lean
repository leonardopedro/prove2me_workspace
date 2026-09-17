-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.invShiftOperator_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_invShiftOperator_symmetricOn
import Theorems.Thm_BookProof_HashimotoShiftInvert_invShiftOperator_quadForm_nonneg
import Theorems.Thm_BookProof_HashimotoShiftInvert_invShiftOperator_selfAdjointCriterion
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F)
    (hinj : Function.Injective R) (γ : ℝ) (hR : IsSelfAdjoint R)
    (hposR : ∀ u : F, γ * ‖R u‖ ^ 2 ≤ (inner ℂ (R u) u : ℂ).re)
    {D : Submodule ℂ F} (hD : D ≤ LinearMap.range (R : F →ₗ[ℂ] F)) (H : D →ₗ[ℂ] F)
    (hH : ∀ x : D, H x = invShiftOperator R hinj γ ⟨(x : F), hD x.2⟩) :
    IsPositiveSelfAdjointExtension H (invShiftOperator R hinj γ) :=
  ⟨fun x => ⟨hD x.2, (hH x).symm⟩, invShiftOperator_symmetricOn R hinj γ hR,
      invShiftOperator_quadForm_nonneg R hinj γ hposR,
      invShiftOperator_selfAdjointCriterion R hinj γ hR⟩
