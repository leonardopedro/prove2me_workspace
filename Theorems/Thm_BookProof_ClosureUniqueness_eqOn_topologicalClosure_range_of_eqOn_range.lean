-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.eqOn_topologicalClosure_range_of_eqOn_range
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterEsaClosureCore
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.eqOn_topologicalClosure_range_of_eqOn_range (B : D →ₗ[ℂ] F) (U V : F →L[ℂ] F)
    (h : ∀ x : D, U (B x) = V (B x)) :
    ∀ z ∈ (LinearMap.range B).topologicalClosure, U z = V z := by sorry
