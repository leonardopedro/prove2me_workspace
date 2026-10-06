-- Generated from ChapterEsaClosureCore.lean — theorem BookProof.EsaClosure.exists_isSelfAdjointExtension_of_esa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterComplexShiftCore
import Mathlib
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterFarisLavineCore
open BookProof.EsaClosure

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}
variable [CompleteSpace F]


open Filter Topology


open BookProof.FarisLavine BookProof.HashimotoShiftInvert


theorem BookProof.EsaClosure.exists_isSelfAdjointExtension_of_esa (T : D →ₗ[ℂ] F) (hdense : Dense (D : Set F))
    (hsym : SymmetricOn D T) (hesa : EssentiallySelfAdjointOn D T) :
    ∃ (Dom : Submodule ℂ F) (A : Dom →ₗ[ℂ] F), IsSelfAdjointExtension T A := by sorry
