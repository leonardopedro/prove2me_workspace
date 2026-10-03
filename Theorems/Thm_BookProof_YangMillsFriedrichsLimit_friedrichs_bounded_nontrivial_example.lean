-- Generated from ChapterYangMillsFriedrichsLimit.lean — theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_nontrivial_example
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterYangMillsFriedrichsLimit
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterYangMillsFriedrichs
open BookProof.YangMillsFriedrichs
open BookProof.YangMillsFriedrichsLimit

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]



open BookProof.FarisLavine BookProof.YangMillsFriedrichs

theorem BookProof.YangMillsFriedrichsLimit.friedrichs_bounded_nontrivial_example [CompleteSpace F] (D : Submodule ℂ F)
    (hdense : Dense (D : Set F)) :
    ∃ A : F →L[ℂ] F, (∀ x : D, A (x : F) = D.subtype x) ∧
      IsPositiveSelfAdjointExtension (D.subtype) (topRestrict A) := by
  refine friedrichs_of_bounded (D.subtype) hdense (fun x y => rfl) (fun x => ?_) 1 (fun x => ?_)
  · simp only [quadForm, Submodule.subtype_apply]
    simpa using inner_self_nonneg (𝕜 := ℂ) (x := (x : F))
  · simp

end Bounded

/-! ### A genuinely proper dense := by sorry
