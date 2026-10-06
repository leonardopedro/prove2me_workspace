-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.ofReal_add
import Mathlib
import Definitions.Def_Complexification
open BookProof.Complexification
open BookProof.Complexification.Cx



open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

set_option maxHeartbeats 1000000 in
theorem solution (a b : W) : ofReal (a + b) = ofReal a + ofReal b := by
 ext <;> simp
