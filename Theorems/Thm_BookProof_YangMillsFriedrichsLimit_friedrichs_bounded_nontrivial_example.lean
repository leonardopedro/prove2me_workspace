-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_nontrivial_example
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_nontrivial_example [CompleteSpace F] (D : Submodule ℂ F)
    (hdense : Dense (D : Set F)) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension (D.subtype) (topRestrict A) := by sorry
