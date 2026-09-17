-- Generated from ChapterFriedrichsExtension.lean — solution of BookProof.FriedrichsExtension.FormDom.friedrichsResolvent_pos
import Mathlib
import Definitions.Def_ChapterFriedrichsExtension
import Theorems.Thm_BookProof_FriedrichsExtension_FormDom_inner_friedrichsResolvent
open BookProof.FriedrichsExtension
open BookProof.FriedrichsExtension.FormDom




open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HashimotoShiftInvert
open BookProof.HermiteGalerkin

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (P : PosSymOp F) (u : F) :
    (1 : ℝ) * ‖friedrichsResolvent P u‖ ^ 2
      ≤ (inner ℂ (friedrichsResolvent P u) u : ℂ).re := by

  have h : (inner ℂ (friedrichsResolvent P u) u : ℂ)
      = starRingEnd ℂ (inner ℂ u (friedrichsResolvent P u)) := (inner_conj_symm _ _).symm
  rw [h, inner_friedrichsResolvent]
  have h2 : (inner ℂ (formRiesz P u) (formRiesz P u) : ℂ) = ((‖formRiesz P u‖ ^ 2 : ℝ) : ℂ) := by
    simp [inner_self_eq_norm_sq_to_K, Complex.ofReal_pow]
  rw [h2]
  simp only [Complex.conj_ofReal, Complex.ofReal_re, one_mul, friedrichsResolvent_apply]
  nlinarith [norm_formExt_apply_le P (formRiesz P u), norm_nonneg (formExt P (formRiesz P u)),
    norm_nonneg (formRiesz P u)]
