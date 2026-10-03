-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.csmul_re
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.csmul_re (z : ℂ) (x : Cx W) : (z • x).re = z.re • x.re - z.im • x.im := by sorry
