-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.repSystem_isNormal
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


theorem BookProof.ChapterSchurRepresentation.repSystem_isNormal {G : Type*} [Group G] (U : G →* (V ≃ₗᵢ[ℂ] V)) :
    (repSystem U).IsNormal := by sorry
