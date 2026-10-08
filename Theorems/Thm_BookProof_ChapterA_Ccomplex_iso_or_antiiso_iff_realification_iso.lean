-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.Ccomplex_iso_or_antiiso_iff_realification_iso
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


theorem BookProof.ChapterA.Ccomplex_iso_or_antiiso_iff_realification_iso [Nontrivial W]
    (M : System ℂ V) (N : System ℂ W)
    (hSchurN : IsSchurFull N) (hNo : NoAntilinearCommutant N) :
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β ∧ (CLinear β ∨ CAntilinear β)) ↔
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β) := by sorry
