-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.not_isRRealType_and_isRComplexType
import Definitions.Def_ChapterA4
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification


theorem BookProof.ChapterA.not_isRRealType_and_isRComplexType (M : System ℝ W) :
    ¬ (IsRRealType M ∧ IsRComplexType M) := by sorry
