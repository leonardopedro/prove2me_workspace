-- Generated from ChapterRelationShiftInvert.lean — solution of BookProof.RelationShiftInvert.unitaryU_eq_of_invCLM_eq
import Mathlib
import Definitions.Def_ChapterRelationShiftInvert
import Theorems.Thm_BookProof_PositiveSquareRoot_rel_eq_of_invCLM_eq
open BookProof.RelationShiftInvert




open BookProof.PositiveSquareRoot BookProof.NonnegSquareRoot BookProof.NonnegResolvent
open BookProof.NonnegUnitaryGroup BookProof.HashimotoShiftInvert

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T T₁ T₂ : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hT₁ : IsNonnegSelfAdjoint T₁) (hT₂ : IsNonnegSelfAdjoint T₂)
    (hsv₁ : ∀ w : F, ((0 : F), w) ∈ T₁ → w = 0) (hsv₂ : ∀ w : F, ((0 : F), w) ∈ T₂ → w = 0)
    (heq : invCLM hT₁ = invCLM hT₂) (t : ℝ) :
    unitaryU hT₁ hsv₁ t = unitaryU hT₂ hsv₂ t := by

  have hTT : T₁ = T₂ := rel_eq_of_invCLM_eq hT₁ hT₂ heq
  subst hTT
  rfl
