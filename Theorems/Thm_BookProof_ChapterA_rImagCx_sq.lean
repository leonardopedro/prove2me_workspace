-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.rImagCx_sq
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterQgOuterFockCoreFL
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary
open BookProof.QgOuterFockCoreFL
open BookProof.QgOuterFockCoreFL.CoreData

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification


theorem BookProof.ChapterA.rImagCx_sq {M : System ℝ W} {J : W ≃ₗᵢ[ℝ] W} (hJ : IsRImaginary M J) (x : Cx W) :
    rImagCx J (rImagCx J x) = -x := by sorry
