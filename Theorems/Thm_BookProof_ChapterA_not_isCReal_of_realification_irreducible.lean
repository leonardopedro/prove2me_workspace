-- Generated from ChapterA1f.lean — theorem BookProof.ChapterA.not_isCReal_of_realification_irreducible
import Mathlib
import Definitions.Def_ChapterA1f
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.not_isCReal_of_realification_irreducible [Nontrivial V] (M : System ℂ V)
    (h : (rxSystem M).IsIrreducible) : ¬ IsCReal M := by sorry
