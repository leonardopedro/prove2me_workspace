-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.schur_unitary_representation
import Definitions.Def_ChapterSchurIrreducible
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
import Definitions.Def_ChapterA
open BookProof.ChapterA
open BookProof.ChapterA.System
open BookProof.ChapterSchurRepresentation

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible


theorem BookProof.ChapterSchurRepresentation.schur_unitary_representation {G : Type*} [Group G] (U : G →* (V ≃ₗᵢ[ℂ] V))
    (hirr : (repSystem U).IsIrreducible) {S : V →L[ℂ] V}
    (hcomm : ∀ g : G, S * uCLM (U g) = uCLM (U g) * S) :
    ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) := by sorry
