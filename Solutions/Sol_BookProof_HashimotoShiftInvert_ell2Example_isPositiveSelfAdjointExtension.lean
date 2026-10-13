-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.ell2Example_isPositiveSelfAdjointExtension
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ShiftInvert_isSelfAdjoint
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ShiftInvert_le_one
import Theorems.Thm_ell2ShiftInvert_injective
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterComplexShiftCore
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology
open BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution :
    IsPositiveSelfAdjointExtension ell2ExampleMatrix ell2UnboundedExample :=
  invShiftOperator_isPositiveSelfAdjointExtension ell2ShiftInvert ell2ShiftInvert_injective 1
      ell2ShiftInvert_isSelfAdjoint ell2ShiftInvert_le_one finiteModeDomain_le_range
      ell2ExampleMatrix (fun _ => rfl)
