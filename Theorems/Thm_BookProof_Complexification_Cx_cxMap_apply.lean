-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxMap_apply
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA4

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.cxMap_apply (m : W →L[ℝ] W) (x : Cx W) : cxMap m x = ⟨m x.re, m x.im⟩ := by sorry
