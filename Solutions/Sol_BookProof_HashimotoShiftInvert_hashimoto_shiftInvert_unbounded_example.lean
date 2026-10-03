-- Generated from ChapterHashimotoShiftInvert.lean — solution of BookProof.HashimotoShiftInvert.hashimoto_shiftInvert_unbounded_example
import Mathlib
import Definitions.Def_ChapterHashimotoShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_isShiftInvert_unique
import Theorems.Thm_BookProof_HashimotoShiftInvert_hashimoto_shiftInvert_selects_friedrichs
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2UnboundedExample_isShiftInvert
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2Example_isPositiveSelfAdjointExtension
import Theorems.Thm_BookProof_HashimotoShiftInvert_ell2ExampleMatrix_unbounded
open BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
  {Dom : Submodule ℂ F}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
 := 
