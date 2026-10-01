-- Generated from ChapterFarisLavineCore.lean — theorem BookProof.FarisLavine.essentiallySelfAdjointOn_top_of_symmetric
import Mathlib
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterComplexShiftCore
import Definitions.Def_ChapterFarisLavine
open BookProof.HashimotoShiftInvert
open BookProof.FarisLavine

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {D : Submodule ℂ F}




theorem BookProof.FarisLavine.essentiallySelfAdjointOn_top_of_symmetric [CompleteSpace F]
    (H : (⊤ : Submodule ℂ F) →ₗ[ℂ] F) (hH : SymmetricOn ⊤ H) :
    EssentiallySelfAdjointOn (⊤ : Submodule ℂ F) H := by sorry
