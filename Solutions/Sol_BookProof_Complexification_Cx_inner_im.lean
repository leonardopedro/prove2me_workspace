-- Generated from Complexification.lean — solution of BookProof.Complexification.Cx.inner_im
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
theorem solution (x y : Cx W) :
    RCLike.im (inner ℂ x y) = inner ℝ x.re y.im - inner ℝ x.im y.re := rfl
