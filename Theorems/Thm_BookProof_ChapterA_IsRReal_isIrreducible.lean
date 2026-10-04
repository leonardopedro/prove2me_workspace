-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.IsRReal.isIrreducible
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

theorem BookProof.ChapterA.IsRReal.isIrreducible {M : System ℝ W} (h : IsRReal M) :
    M.IsIrreducible := by sorry
