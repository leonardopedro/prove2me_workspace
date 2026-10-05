-- Generated from ChapterSchurRepresentation.lean — solution of BookProof.ChapterSchurRepresentation.schur_unitary_representation
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
import Theorems.Thm_BookProof_ChapterSchurRepresentation_repSystem_isNormal
import Theorems.Thm_BookProof_ChapterSchurIrreducible_commutant_scalar_of_irreducible
open BookProof.ChapterSchurRepresentation



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {G : Type*} [Group G] (U : G →* (V ≃ₗᵢ[ℂ] V))
    (hirr : (repSystem U).IsIrreducible) {S : V →L[ℂ] V}
    (hcomm : ∀ g : G, S * uCLM (U g) = uCLM (U g) * S) :
    ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) :=
  commutant_scalar_of_irreducible (repSystem U) (repSystem_isNormal U) hirr
      (by rintro m ⟨g, rfl⟩; exact hcomm g)
