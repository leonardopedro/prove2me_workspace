-- Generated from ChapterA2e.lean — theorem BookProof.ChapterA.Cpseudoreal_realification_dichotomy
import Mathlib
import Definitions.Def_ChapterA2e
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]
variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.Cpseudoreal_realification_dichotomy [Nontrivial W]
    {M : System ℂ V} {N : System ℂ W} (hSchurN : IsSchurFull N)
    {θN : AntiUnitary W} (hθN : ∀ x, θN (θN x) = -x) (hθNc : CommutesAntiUnitary N θN)
    {β : V ≃ₗᵢ[ℝ] W} (hβ : IsRealSystemIso M N β) :
    ∃ γ : V ≃ₗᵢ[ℝ] W, IsRealSystemIso M N γ ∧ (CLinear γ ∨ CAntilinear γ) := by sorry
