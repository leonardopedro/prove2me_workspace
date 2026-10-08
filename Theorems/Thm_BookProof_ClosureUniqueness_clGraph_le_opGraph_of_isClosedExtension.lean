-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.clGraph_le_opGraph_of_isClosedExtension
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.clGraph_le_opGraph_of_isClosedExtension {T : D →ₗ[ℂ] F} {A : Dom →ₗ[ℂ] F}
    (h : IsClosedExtension T A) : clGraph T ≤ opGraph A := by sorry
