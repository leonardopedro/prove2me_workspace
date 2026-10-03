-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxConj_comm_cxMap
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_ChapterA4
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false


theorem BookProof.Complexification.Cx.cxConj_comm_cxMap (m : W →L[ℝ] W) (x : Cx W) :
    cxConj (cxMap m x) = cxMap m (cxConj x) := by sorry
