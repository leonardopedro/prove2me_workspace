-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.symmetricOn_top_of_dense
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.symmetricOn_top_of_dense {D : Submodule ℂ F} (A : F →L[ℂ] F)
    (hdense : Dense (D : Set F)) (hsym : ∀ x y : D, (inner ℂ (A (x : F)) (y : F) : ℂ)
      = inner ℂ (x : F) (A (y : F))) :
    SymmetricOn (⊤ : Submodule ℂ F) (topRestrict A) := by sorry
