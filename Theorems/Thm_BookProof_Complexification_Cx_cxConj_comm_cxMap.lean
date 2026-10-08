-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_comm_cxMap
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


theorem BookProof.Complexification.Cx.cxConj_comm_cxMap (m : W →L[ℝ] W) (x : Cx W) :
    cxConj (cxMap m x) = cxMap m (cxConj x) := by sorry
