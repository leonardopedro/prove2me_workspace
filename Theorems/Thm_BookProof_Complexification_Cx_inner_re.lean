-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.inner_re
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.inner_re (x y : Cx W) :
    RCLike.re (inner ℂ x y) = inner ℝ x.re y.re + inner ℝ x.im y.im := by sorry
