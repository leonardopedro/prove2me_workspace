-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.cType_exhaustive
import Mathlib
import Definitions.Def_ChapterA1c
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution (M : System ℂ V) :
    IsCReal M ∨ IsCPseudoreal M ∨ IsCComplex M := by

  by_cases h1 : IsCReal M
  · exact Or.inl h1
  · by_cases h2 : HasCommutingAntiUnitary M
    · exact Or.inr (Or.inl ⟨h1, h2⟩)
    · exact Or.inr (Or.inr h2)
