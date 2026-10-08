-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_involutive
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


theorem BookProof.Complexification.Cx.cxConj_involutive (x : Cx W) : cxConj (cxConj x) = x := by sorry
