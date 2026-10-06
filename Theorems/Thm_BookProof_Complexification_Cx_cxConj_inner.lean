-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_inner
import Mathlib
import Definitions.Def_Complexification
open BookProof.Complexification
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.cxConj_inner (x y : Cx W) :
    inner ℂ (cxConj x) (cxConj y) = starRingEnd ℂ (inner ℂ x y) := by sorry
