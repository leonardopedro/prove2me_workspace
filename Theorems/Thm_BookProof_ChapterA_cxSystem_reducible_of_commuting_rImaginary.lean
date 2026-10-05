-- Generated from ChapterA1h.lean — theorem BookProof.ChapterA.cxSystem_reducible_of_commuting_rImaginary
import Definitions.Def_Complexification
import Mathlib
import Definitions.Def_ChapterA1h
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary

variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


open BookProof.Complexification


theorem BookProof.ChapterA.cxSystem_reducible_of_commuting_rImaginary [Nontrivial W] (M : System ℝ W)
    (h : HasCommutingRImaginary M) : ¬ (cxSystem M).IsIrreducible := by sorry
