-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.farisLavine_clGraph_eq_of_cores
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}
variable [CompleteSpace F]



open BookProof.FarisLavine BookProof.EsaClosure


theorem BookProof.ClosureUniqueness.farisLavine_clGraph_eq_of_cores {T : D →ₗ[ℂ] F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h₁ : IsCoreOf T₁ T) (h₂ : IsCoreOf T₂ T) :
    clGraph T₁ = clGraph T₂ ∧ clDom T₁ = clDom T₂ ∧ adjGraph T₁ = adjGraph T₂ := by sorry
