-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.unbounded_friedrichs_example
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_friedrichs_extension_exists
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ExampleMatrix_unbounded
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_HermiteGalerkin_finiteModeDomain_dense
open BookProof.FriedrichsExtension




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin
open scoped InnerProductSpace ENNReal lp

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable [CompleteSpace F]

set_option maxHeartbeats 1000000 in
tion is not vacuous: a genuinely unbounded op := 
