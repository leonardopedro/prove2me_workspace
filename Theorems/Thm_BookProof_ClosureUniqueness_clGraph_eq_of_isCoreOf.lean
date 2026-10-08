-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.clGraph_eq_of_isCoreOf
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.clGraph_eq_of_isCoreOf {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F} (h : IsCoreOf T₁ T₂) :
    clGraph T₁ = clGraph T₂ := by sorry
