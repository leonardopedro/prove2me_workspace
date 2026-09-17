-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.formExt_injective
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_inner_coe_eq
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) : Function.Injective (formExt P) := by

  rw [injective_iff_map_eq_zero]
  intro k hk
  have hzero : ∀ y : FormDom P, (inner ℂ (y : FormSpace P) k : ℂ) = 0 := by
    intro y
    rw [inner_coe_eq, hk, inner_zero_right]
  have hall : ∀ z : FormSpace P, (inner ℂ z k : ℂ) = 0 := by
    intro z
    refine UniformSpace.Completion.induction_on z ?_ hzero
    exact isClosed_eq (by fun_prop) (by fun_prop)
  simpa using hall k
