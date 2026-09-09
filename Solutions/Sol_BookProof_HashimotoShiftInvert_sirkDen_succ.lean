-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.sirkDen_succ
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
open BookProof.HashimotoShiftInvert



















open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology




variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}


















variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (Xm : F →L[ℂ] F) (c : ℕ → ℂ) (k : ℕ) :
    sirkDen Xm c (k + 1) = (ContinuousLinearMap.id ℂ F - c k • Xm) ∘L sirkDen Xm c k := rfl
