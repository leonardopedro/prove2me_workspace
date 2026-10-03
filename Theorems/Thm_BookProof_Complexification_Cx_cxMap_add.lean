-- Generated from Complexification.lean — theorem BookProof.Complexification.Cx.cxMap_add
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


theorem BookProof.Complexification.Cx.cxMap_add (m n : W →L[ℝ] W) : cxMap (m + n) = cxMap m + cxMap n := by sorry
