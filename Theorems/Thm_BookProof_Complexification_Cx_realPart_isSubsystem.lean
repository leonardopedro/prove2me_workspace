-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.realPart_isSubsystem
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterA
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_Complexification
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.Complexification
open BookProof.Complexification


open scoped RealInnerProductSpace
open BookProof.ChapterA


variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]

variable [CompleteSpace W]

theorem BookProof.Complexification.Cx.realPart_isSubsystem (M : System ℝ W) {X : Submodule ℂ (Cx W)}
    (hX : (cxSystem M).IsSubsystem X) : (M).IsSubsystem (realPart X) := by sorry
