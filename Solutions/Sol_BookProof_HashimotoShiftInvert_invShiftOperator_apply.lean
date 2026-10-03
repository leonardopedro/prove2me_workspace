-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.invShiftOperator_apply
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (R : F →L[ℂ] F) (hinj : Function.Injective R) (γ : ℝ)
    (y : LinearMap.range (R : F →ₗ[ℂ] F)) :
    invShiftOperator R hinj γ y = preim R y - (γ : ℂ) • (y : F) := rfl
