-- Generated from ChapterA1d.lean — theorem BookProof.ChapterA.Jmap_isRImaginary
import Mathlib
import Definitions.Def_ChapterA1d
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace




attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V]


theorem BookProof.ChapterA.Jmap_isRImaginary [CompleteSpace V] (M : System ℂ V) :
    IsRImaginary (rxSystem M) Jmap := by sorry
