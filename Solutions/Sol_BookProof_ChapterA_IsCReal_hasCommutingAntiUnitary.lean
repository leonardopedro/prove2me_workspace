-- Generated from ChapterA1c.lean — solution of BookProof.ChapterA.IsCReal.hasCommutingAntiUnitary
import Mathlib
import Definitions.Def_ChapterA1c
import Theorems.Thm_BookProof_ChapterA_IsConjugation_commutesAntiUnitary
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace RealInnerProductSpace

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} (h : IsCReal M) :
    HasCommutingAntiUnitary M := by

  obtain ⟨θ, hθ⟩ := h
  exact ⟨θ, hθ.commutesAntiUnitary⟩
