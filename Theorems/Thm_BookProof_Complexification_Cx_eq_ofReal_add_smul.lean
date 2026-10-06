-- Generated from ChapterA1b.lean — theorem BookProof.Complexification.Cx.eq_ofReal_add_smul
import Definitions.Def_ChapterA
import Mathlib
import Definitions.Def_ChapterA1b
import Definitions.Def_ChapterQgOuterFockCoreFL
import Definitions.Def_Complexification
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData
open BookProof.Complexification
open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


open scoped RealInnerProductSpace
open BookProof.ChapterA



theorem BookProof.Complexification.Cx.eq_ofReal_add_smul (x : Cx W) : x = ofReal x.re + (Complex.I : ℂ) • ofReal x.im := by sorry
