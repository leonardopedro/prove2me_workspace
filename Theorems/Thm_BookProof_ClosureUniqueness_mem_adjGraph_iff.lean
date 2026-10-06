-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.mem_adjGraph_iff
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}



open BookProof.FarisLavine BookProof.EsaClosure


theorem BookProof.ClosureUniqueness.mem_adjGraph_iff {T : D →ₗ[ℂ] F} {p : F × F} :
    p ∈ adjGraph T ↔ ∀ v : D, (inner ℂ (T v) p.1 : ℂ) = inner ℂ (v : F) p.2 := by sorry
