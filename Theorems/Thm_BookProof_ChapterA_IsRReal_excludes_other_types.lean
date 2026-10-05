-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.IsRReal.excludes_other_types
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification


theorem BookProof.ChapterA.IsRReal.excludes_other_types [Nontrivial W] {M : System ℝ W}
    (h : IsRReal M) : IsRRealType M ∧ ¬ IsRComplexType M ∧ ¬ IsRPseudorealType M := by sorry
