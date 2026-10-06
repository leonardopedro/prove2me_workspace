-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.inner_im
import Mathlib
import Definitions.Def_Complexification
open BookProof.Complexification
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.inner_im (x y : Cx W) :
    RCLike.im (inner ℂ x y) = inner ℝ x.re y.im - inner ℝ x.im y.re := by sorry
