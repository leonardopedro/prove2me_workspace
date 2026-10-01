-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.ell2ShiftInvert_isSelfAdjoint
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_diagCLM_isSelfAdjoint
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

set_option maxHeartbeats 1000000 in
e_zero

theorem solution : IsSelfAdjoint ell2Shif :=
  tInvert :=
    diagCLM_isSelfAdjoint invCoeff_ab
