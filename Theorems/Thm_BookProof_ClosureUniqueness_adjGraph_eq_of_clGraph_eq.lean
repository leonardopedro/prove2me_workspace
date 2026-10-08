-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.adjGraph_eq_of_clGraph_eq
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.adjGraph_eq_of_clGraph_eq {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h : clGraph T₁ = clGraph T₂) : adjGraph T₁ = adjGraph T₂ := by sorry
