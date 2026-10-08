-- Generated from Complexification.lean — theorem BookProof.Complexification.cxConj_isConjugation
import Mathlib
import Definitions.Def_Complexification
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary
open BookProof.Complexification


open scoped RealInnerProductSpace
open RCLike


set_option linter.unusedSectionVars false

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W]


theorem BookProof.Complexification.cxConj_isConjugation [CompleteSpace W] (M : System ℝ W) :
    IsConjugation (cxSystem M) Cx.cxConj := by sorry
