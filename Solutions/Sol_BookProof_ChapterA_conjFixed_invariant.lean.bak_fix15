-- Generated from ChapterA1f.lean — solution of BookProof.ChapterA.conjFixed_invariant
import Mathlib
import Definitions.Def_ChapterA1f
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace


attribute [local instance] InnerProductSpace.rclikeToReal

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) (θ : AntiUnitary V) (hθ : IsConjugation M θ) :
    ∀ m ∈ (rxSystem M).ops, ∀ w ∈ conjFixed θ, m w ∈ conjFixed θ := by

  rintro _ ⟨m, hm, rfl⟩ w hw
  rw [mem_conjFixed] at *
  change θ (m w) = m w
  rw [hθ.2 m hm w, hw]
