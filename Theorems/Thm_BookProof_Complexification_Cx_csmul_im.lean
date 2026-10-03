-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.csmul_im
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.csmul_im (z : ℂ) (x : Cx W) : (z • x).im = z.re • x.im + z.im • x.re := by sorry
