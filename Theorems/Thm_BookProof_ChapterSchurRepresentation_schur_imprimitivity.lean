-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.schur_imprimitivity
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
import Definitions.Def_ChapterA
import Definitions.Def_ChapterA4
open BookProof.ChapterA
open BookProof.ChapterA.System
open BookProof.ChapterSchurRepresentation

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible


theorem BookProof.ChapterSchurRepresentation.schur_imprimitivity {G : Type*} [Group G] {X : Type*}
    (U : G →* (V ≃ₗᵢ[ℂ] V)) (pvm : Set X → (V →L[ℂ] V))
    (hpvm : ∀ A : Set X, IsSelfAdjoint (pvm A))
    (hirr : (imprimitivitySystem U pvm).IsIrreducible) {S : V →L[ℂ] V}
    (hU : ∀ g : G, S * uCLM (U g) = uCLM (U g) * S)
    (hP : ∀ A : Set X, S * pvm A = pvm A * S) :
    ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := by sorry
