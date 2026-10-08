-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.factorGraph_eq_of_isCoreOf_pair
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.factorGraph_eq_of_isCoreOf_pair {T : D →ₗ[ℂ] F} {T₁ : D₁ →ₗ[ℂ] F} {T₂ : D₂ →ₗ[ℂ] F}
    (h₁ : IsCoreOf T₁ T) (h₂ : IsCoreOf T₂ T) : factorGraph T₁ = factorGraph T₂ := by sorry
