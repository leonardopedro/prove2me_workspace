-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.csmul_im
import Mathlib
import Definitions.Def_Complexification



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (z : ℂ) (x : Cx W) : (z • x).im = z.re • x.im + z.im • x.re := rfl
