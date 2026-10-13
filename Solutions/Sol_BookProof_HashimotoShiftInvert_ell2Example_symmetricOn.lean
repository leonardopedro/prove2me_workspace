-- Generated from ChapterHashimotoComplexShifts.lean — solution of BookProof.HashimotoShiftInvert.ell2Example_symmetricOn
import Mathlib
import Definitions.Def_ChapterHashimotoComplexShifts
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_isPositiveSelfAdjointExtension
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHashimotoShiftInvert
import Definitions.Def_ChapterHermiteGalerkinFriedrichs
import Definitions.Def_ChapterComplexShiftCore
open scoped InnerProductSpace
open scoped lp
open BookProof.HashimotoShiftInvert




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.YangMillsFriedrichsLimit
open BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution :
    SymmetricOn (LinearMap.range (ell2ShiftInvert : ℓ²(ℕ, ℂ) →ₗ[ℂ] ℓ²(ℕ, ℂ)))
      ell2UnboundedExample :=
  Example :=
    ell2Example_isPositiveSelfAdjointExten
