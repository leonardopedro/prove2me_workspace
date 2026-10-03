-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_apply
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.cxConj_apply (x : Cx W) : cxConj x = ⟨x.re, -x.im⟩ := by sorry
