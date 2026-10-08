-- Generated from ChapterA2.lean — theorem BookProof.ChapterA.antiisometry_unique_up_to_phase
import Mathlib
import Definitions.Def_ChapterA2
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterA.antiisometry_unique_up_to_phase (M : System ℂ V) (hSchur : IsSchurUnitary M)
    {θ₁ θ₂ : AntiUnitary V} (h₁ : CommutesAntiUnitary M θ₁) (h₂ : CommutesAntiUnitary M θ₂) :
    ∃ c : ℂ, ‖c‖ = 1 ∧ ∀ x, θ₂ x = c • θ₁ x := by sorry
