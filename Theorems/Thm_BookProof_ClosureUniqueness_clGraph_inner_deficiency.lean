-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.clGraph_inner_deficiency
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.clGraph_inner_deficiency {T : D →ₗ[ℂ] F} {w : F}
    (hw : ∀ v : D, (inner ℂ (T v) w : ℂ) = Complex.I * inner ℂ (v : F) w) {p : F × F}
    (hp : p ∈ clGraph T) : (inner ℂ p.2 w : ℂ) = Complex.I * inner ℂ p.1 w := by sorry
