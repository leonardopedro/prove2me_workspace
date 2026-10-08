-- Generated from ChapterA1f.lean — theorem BookProof.ChapterA.conjFixed_isClosed
import Mathlib
import Definitions.Def_ChapterA1f
import Definitions.Def_ChapterA1
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.conjFixed_isClosed (θ : AntiUnitary V) :
    IsClosed ((conjFixed θ : Submodule ℝ V) : Set V) := by sorry
