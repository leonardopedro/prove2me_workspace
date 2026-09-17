-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.friedrichsResolvent_injective
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_formExt_injective
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_dense_range_formExt
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (hdense : Dense (P.dom : Set F)) :
    Function.Injective (friedrichsResolvent P) := by

  rw [injective_iff_map_eq_zero]
  intro u hu
  have h0 : formRiesz P u = 0 := formExt_injective P (by simpa using hu)
  have hall : ∀ k : FormSpace P, (inner ℂ u (formExt P k) : ℂ) = 0 := by
    intro k
    rw [← formRiesz_spec, h0, inner_zero_left]
  have hzero : ∀ v : F, (inner ℂ u v : ℂ) = 0 := by
    intro v
    have hc : Continuous fun w : F => (inner ℂ u w : ℂ) := (innerSL ℂ u).continuous
    have heq : Set.EqOn (fun w : F => (inner ℂ u w : ℂ)) (fun _ => (0 : ℂ))
        (Set.range (formExt P)) := by
      rintro _ ⟨k, rfl⟩
      exact hall k
    exact congrFun (Continuous.ext_on (dense_range_formExt P hdense) hc continuous_const heq) v
  simpa using hzero u
