-- Generated from ChapterA2d.lean — theorem BookProof.ChapterA.Rreal_isometric_iff_complexification_isometric
import Mathlib
import Definitions.Def_ChapterA2d
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA


open scoped ComplexConjugate InnerProductSpace


variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


theorem BookProof.ChapterA.Rreal_isometric_iff_complexification_isometric
    (M : System ℂ V) (N : System ℂ W) (hN : IsSchurUnitary N)
    {θM : AntiUnitary V} {θN : AntiUnitary W}
    (hθM : IsConjugation M θM) (hθN : IsConjugation N θN) :
    (∃ α : V ≃ₗᵢ[ℂ] W, IsSystemIso M N α ∧ ∀ x, α (θM x) = θN (α x)) ↔
    (∃ α : V ≃ₗᵢ[ℂ] W, IsSystemIso M N α) := by sorry
