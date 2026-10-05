-- Generated from ChapterA2e.lean — solution of BookProof.ChapterA.Ccomplex_iso_or_antiiso_iff_realification_iso
import Mathlib
import Definitions.Def_ChapterA2e
import Theorems.Thm_BookProof_ChapterA_Ccomplex_realification_dichotomy
open BookProof.ChapterA



open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

set_option maxHeartbeats 1000000 in
theorem solution [Nontrivial W]
    (M : System ℂ V) (N : System ℂ W)
    (hSchurN : IsSchurFull N) (hNo : NoAntilinearCommutant N) :
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β ∧ (CLinear β ∨ CAntilinear β)) ↔
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β) := by

  constructor
  · rintro ⟨β, hβ, _⟩; exact ⟨β, hβ⟩
  · rintro ⟨β, hβ⟩
    exact ⟨β, hβ, Ccomplex_realification_dichotomy hSchurN hNo hβ⟩
