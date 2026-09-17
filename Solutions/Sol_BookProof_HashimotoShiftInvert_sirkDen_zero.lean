-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.sirkDen_zero
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution (Xm : F →L[ℂ] F) (c : ℕ → ℂ) :
    sirkDen Xm c 0 = ContinuousLinearMap.id ℂ F := rfl
