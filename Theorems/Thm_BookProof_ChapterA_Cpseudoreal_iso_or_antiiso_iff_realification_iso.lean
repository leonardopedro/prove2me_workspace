-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.Cpseudoreal_iso_or_antiiso_iff_realification_iso
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

theorem BookProof.ChapterA.Cpseudoreal_iso_or_antiiso_iff_realification_iso [Nontrivial W]
    (M : System ℂ V) (N : System ℂ W) (hSchurN : IsSchurFull N)
    {θN : AntiUnitary W} (hθN : ∀ x, θN (θN x) = -x) (hθNc : CommutesAntiUnitary N θN) :
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β ∧ (CLinear β ∨ CAntilinear β)) ↔
    (∃ β : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N β) := by sorry
