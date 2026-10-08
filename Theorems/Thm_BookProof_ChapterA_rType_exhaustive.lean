-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.rType_exhaustive
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


theorem BookProof.ChapterA.rType_exhaustive (M : System ℝ W) :
    IsRRealType M ∨ IsRComplexType M ∨ IsRPseudorealType M := by sorry
