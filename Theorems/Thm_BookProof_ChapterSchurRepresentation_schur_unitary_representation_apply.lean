-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.schur_unitary_representation_apply
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


theorem BookProof.ChapterSchurRepresentation.schur_unitary_representation_apply {G : Type*} [Group G] (U : G →* (V ≃ₗᵢ[ℂ] V))
    (hirr : (repSystem U).IsIrreducible) {S : V →L[ℂ] V}
    (hcomm : ∀ (g : G) (x : V), S (U g x) = U g (S x)) :
    ∃ c : ℂ, ∀ x, S x = c • x := by sorry
