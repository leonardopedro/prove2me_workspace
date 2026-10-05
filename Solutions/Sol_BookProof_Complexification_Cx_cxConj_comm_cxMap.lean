-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.cxConj_comm_cxMap
import Mathlib
import Definitions.Def_Complexification



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (m : W →L[ℝ] W) (x : Cx W) :
    cxConj (cxMap m x) = cxMap m (cxConj x) := by

  ext <;> simp
