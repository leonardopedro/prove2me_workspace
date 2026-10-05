-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.IsRPseudorealType.not_isRReal
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification


theorem BookProof.ChapterA.IsRPseudorealType.not_isRReal [Nontrivial W] {M : System ℝ W}
    (h : IsRPseudorealType M) : ¬ IsRReal M := by sorry
