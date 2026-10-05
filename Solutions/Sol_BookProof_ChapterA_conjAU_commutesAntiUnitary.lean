-- Generated from ChapterA2d.lean — solution of BookProof.ChapterA.conjAU_commutesAntiUnitary
import Mathlib
import Definitions.Def_ChapterA2d
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution {M : System ℂ V} {N : System ℂ W} {α : V ≃ₗᵢ[ℂ] W}
    (hα : IsSystemIso M N α) {θ : AntiUnitary V} (hθ : CommutesAntiUnitary M θ) :
    CommutesAntiUnitary N (conjAU α θ) := by

  intro n hn; simp_all [ IsSystemIso, CommutesAntiUnitary ] ;
  obtain ⟨ m, hm, rfl ⟩ := hn; simp [ conjCLM_apply, hθ m hm ] ;
