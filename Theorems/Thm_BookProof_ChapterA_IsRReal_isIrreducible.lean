-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.IsRReal.isIrreducible
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

theorem BookProof.ChapterA.IsRReal.isIrreducible {M : System ℝ W} (h : IsRReal M) :
    M.IsIrreducible := by sorry
