-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_fixed_iff
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.Complexification
open BookProof.Complexification


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


theorem BookProof.Complexification.Cx.cxConj_fixed_iff (x : Cx W) : cxConj x = x ↔ x.im = 0 := by sorry
