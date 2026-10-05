-- Generated from ChapterSchurRepresentation.lean — solution of BookProof.ChapterSchurRepresentation.schur_imprimitivity
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
import Theorems.Thm_BookProof_ChapterSchurRepresentation_imprimitivitySystem_isNormal
import Theorems.Thm_BookProof_ChapterSchurIrreducible_commutant_scalar_of_irreducible
open BookProof.ChapterSchurRepresentation



open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]

set_option maxHeartbeats 1000000 in
theorem solution {G : Type*} [Group G] {X : Type*}
    (U : G →* (V ≃ₗᵢ[ℂ] V)) (pvm : Set X → (V →L[ℂ] V))
    (hpvm : ∀ A : Set X, IsSelfAdjoint (pvm A))
    (hirr : (imprimitivitySystem U pvm).IsIrreducible) {S : V →L[ℂ] V}
    (hU : ∀ g : G, S * uCLM (U g) = uCLM (U g) * S)
    (hP : ∀ A : Set X, S * pvm A = pvm A * S) :
    ∃ c : ℂ, S = c • (1 : V →L[ℂ] V) :=
  commutant_scalar_of_irreducible (imprimitivitySystem U pvm)
      (imprimitivitySystem_isNormal U pvm hpvm) hirr
      (by
        rintro m (⟨g, rfl⟩ | ⟨A, rfl⟩)
        · exact hU g
        · exact hP A)
