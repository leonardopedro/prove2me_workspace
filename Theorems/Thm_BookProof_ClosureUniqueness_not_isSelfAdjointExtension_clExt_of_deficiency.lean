-- Generated from ChapterClosureUniqueness.lean — theorem BookProof.ClosureUniqueness.not_isSelfAdjointExtension_clExt_of_deficiency
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterClosureUniqueness
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure
open BookProof.ClosureUniqueness



open BookProof.FarisLavine BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D D₁ D₂ Dom Dom₁ Dom₂ : Submodule ℂ F}


theorem BookProof.ClosureUniqueness.not_isSelfAdjointExtension_clExt_of_deficiency (T : D →ₗ[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : SymmetricOn D T) {w : F} (hw0 : w ≠ 0)
    (hw : ∀ v : D, (inner ℂ (T v) w : ℂ) = Complex.I * inner ℂ (v : F) w) :
    ¬ IsSelfAdjointExtension T (clExt T hdense hsym) := by sorry
