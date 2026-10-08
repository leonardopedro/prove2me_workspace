-- Generated from ChapterA1f.lean — theorem BookProof.ChapterA.isCReal_realification_reducible
import Mathlib
import Definitions.Def_ChapterA1f
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.AntiUnitary


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.isCReal_realification_reducible [Nontrivial V] (M : System ℂ V)
    (h : IsCReal M) : ¬ (rxSystem M).IsIrreducible := by sorry
