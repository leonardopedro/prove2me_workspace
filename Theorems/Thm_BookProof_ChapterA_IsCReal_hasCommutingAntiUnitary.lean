-- Generated from ChapterA1c.lean — theorem BookProof.ChapterA.IsCReal.hasCommutingAntiUnitary
import Mathlib
import Definitions.Def_ChapterA1c
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

theorem BookProof.ChapterA.IsCReal.hasCommutingAntiUnitary {M : System ℂ V} (h : IsCReal M) :
    HasCommutingAntiUnitary M := by sorry
