-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.cxMap_apply
import Mathlib
import Definitions.Def_Complexification



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (m : W →L[ℝ] W) (x : Cx W) : cxMap m x = ⟨m x.re, m x.im⟩ := rfl
