-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.inner_def
import Mathlib
import Definitions.Def_Complexification



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (x y : Cx W) : inner ℂ x y = cxInner x y := rfl
