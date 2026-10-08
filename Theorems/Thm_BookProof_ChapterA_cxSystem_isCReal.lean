-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.cxSystem_isCReal
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℝ W] [CompleteSpace W]

theorem BookProof.ChapterA.cxSystem_isCReal (M : System ℝ W) : IsCReal (cxSystem M) := by sorry
