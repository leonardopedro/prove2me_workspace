-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.realification_reducible_of_conjugation
import Mathlib
import Definitions.Def_ChapterA1f
import Theorems.Thm_BookProof_ChapterA_conjFixed_isSubsystem
import Theorems.Thm_BookProof_ChapterA_conjFixed_ne_bot
import Theorems.Thm_BookProof_ChapterA_conjFixed_ne_top
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial V] (M : System ℂ V)
    (θ : AntiUnitary V) (hθ : IsConjugation M θ) : ¬ (rxSystem M).IsIrreducible := by

  intro hirr
  rcases hirr (conjFixed θ) (conjFixed_isSubsystem M θ hθ) with h | h
  · exact conjFixed_ne_bot θ hθ.1 h
  · exact conjFixed_ne_top θ h
