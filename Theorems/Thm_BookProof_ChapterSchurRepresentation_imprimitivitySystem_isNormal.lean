-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.imprimitivitySystem_isNormal
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


theorem BookProof.ChapterSchurRepresentation.imprimitivitySystem_isNormal {G : Type*} [Group G] {X : Type*}
    (U : G →* (V ≃ₗᵢ[ℂ] V)) (pvm : Set X → (V →L[ℂ] V))
    (hpvm : ∀ A : Set X, IsSelfAdjoint (pvm A)) :
    (imprimitivitySystem U pvm).IsNormal := by sorry
