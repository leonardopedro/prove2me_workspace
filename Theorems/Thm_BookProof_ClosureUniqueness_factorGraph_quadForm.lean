-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.factorGraph_quadForm
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.factorGraph_quadForm {A : D →ₗ[ℂ] F} {p : F × F} (hp : p ∈ factorGraph A) :
    ∃ y : F, (p.1, y) ∈ clGraph A ∧ (inner ℂ p.1 p.2 : ℂ) = ((‖y‖ ^ 2 : ℝ) : ℂ) := by sorry
