-- Generated from ChapterSchurFiniteDimensional.lean — solution of BookProof.ChapterSchurFiniteDimensional.isConjugation_or_sq_eq_neg_one
import Mathlib
import Definitions.Def_ChapterSchurFiniteDimensional
import Theorems.Thm_BookProof_ChapterSchurFiniteDimensional_antiUnitary_sq_of_irreducible_finiteDimensional
open BookProof.ChapterSchurFiniteDimensional



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution [FiniteDimensional ℂ V] [Nontrivial V]
    (M : System ℂ V) (hirr : M.IsIrreducible) {θ : AntiUnitary V}
    (hθ : CommutesAntiUnitary M θ) :
    IsConjugation M θ ∨ ((∀ x, θ (θ x) = -x) ∧ ∀ m ∈ M.ops, ∀ x, θ (m x) = m (θ x)) := by

  rcases antiUnitary_sq_of_irreducible_finiteDimensional M hirr hθ with h | h
  · exact Or.inl ⟨h, fun m hm x => hθ m hm x⟩
  · exact Or.inr ⟨h, fun m hm x => hθ m hm x⟩
