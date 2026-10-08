-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.symmetricOn_top_of_dense
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterYangMillsFriedrichs
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
open BookProof.YangMillsFriedrichsLimit



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichsLimit.symmetricOn_top_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : ∀ x y : D, (inner ℂ (A (x : F)) (y : F) : ℂ)
      = inner ℂ (x : F) (A (y : F))) :
    SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by sorry
