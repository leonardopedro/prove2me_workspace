-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.IsRReal.cxSystem_isCReal
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

theorem BookProof.ChapterA.IsRReal.cxSystem_isCReal {M : System ℝ W} (_ : IsRReal M) :
    IsCReal (cxSystem M) := by sorry
