-- Generated from ChapterA2d.lean — theorem BookProof.ChapterA.conjAU_commutesAntiUnitary
import Mathlib
import Definitions.Def_ChapterA2d
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA1
open BookProof.ChapterA
open BookProof.ChapterA
open BookProof.ChapterA

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]
variable {W : Type*} [NormedAddCommGroup W] [InnerProductSpace ℂ W] [CompleteSpace W]


open scoped ComplexConjugate InnerProductSpace



theorem BookProof.ChapterA.conjAU_commutesAntiUnitary {M : System ℂ V} {N : System ℂ W} {α : V ≃ₗᵢ[ℂ] W}
    (hα : IsSystemIso M N α) {θ : AntiUnitary V} (hθ : CommutesAntiUnitary M θ) :
    CommutesAntiUnitary N (conjAU α θ) := by sorry
