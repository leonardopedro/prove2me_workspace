-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.isCReal_realification_reducible
import Mathlib
import Definitions.Def_ChapterA1f
import Theorems.Thm_BookProof_ChapterA_realification_reducible_of_conjugation
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] (M : System ℂ V)
    (h : IsCReal M) : ¬ (rxSystem M).IsIrreducible := by

  obtain ⟨θ, hθ⟩ := h
  exact realification_reducible_of_conjugation M θ hθ
