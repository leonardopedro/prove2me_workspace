-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.not_isCReal_of_realification_irreducible
import Mathlib
import Definitions.Def_ChapterA1f
import Theorems.Thm_BookProof_ChapterA_isCReal_realification_reducible
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] (M : System ℂ V)
    (h : (rxSystem M).IsIrreducible) : ¬ IsCReal M := fun hc => isCReal_realification_reducible M hc h
