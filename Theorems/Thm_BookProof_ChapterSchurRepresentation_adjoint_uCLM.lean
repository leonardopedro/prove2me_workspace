-- Generated from ChapterSchurRepresentation.lean — theorem BookProof.ChapterSchurRepresentation.adjoint_uCLM
import Definitions.Def_ChapterA
import Definitions.Def_ChapterSchurIrreducible
import Mathlib
import Definitions.Def_ChapterSchurRepresentation
open BookProof.ChapterSchurRepresentation


open scoped ComplexConjugate InnerProductSpace


open BookProof.ChapterA BookProof.ChapterA.System BookProof.ChapterSchurIrreducible

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℂ V] [CompleteSpace V]


theorem BookProof.ChapterSchurRepresentation.adjoint_uCLM (f : V ≃ₗᵢ[ℂ] V) :
    ContinuousLinearMap.adjoint (uCLM f) = uCLM f.symm := by sorry
