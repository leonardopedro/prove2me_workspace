-- Generated from ChapterQgTimeStepping.lean — solution of BookProof.QgTimeStepping.norm_cnStep_apply
import Mathlib
import Definitions.Def_ChapterQgTimeStepping
import Theorems.Thm_BookProof_QgTimeStepping_two_div_ne_zero
import Theorems.Thm_BookProof_QgTimeStepping_cnStep_eq_neg_shift




open Filter Topology
open BookProof.ChapterStoneResolvent BookProof.ChapterSirkTrotterKato
open BookProof.FarisLavine BookProof.EsaClosure BookProof.StoneBridge

noncomputable section

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

variable {H : Type*} [NormedAddCommGroup H] [InnerProductSpace ℂ H] [CompleteSpace H]

set_option maxHeartbeats 1000000 in
theorem solution (T : UnboundedSelfAdjoint H) {tau : ℝ} (h : tau ≠ 0) (y : H) :
    ‖cnStep T tau y‖ = ‖y‖ := by

  have hl : (2 / tau : ℝ) ≠ 0 := two_div_ne_zero h
  have h1 := T.norm_shift_sq (-(2 / tau)) (T.res (2 / tau) y)
  have h2 := T.norm_shift_sq (2 / tau) (T.res (2 / tau) y)
  rw [T.shift_res hl] at h2
  have hsq : ‖cnStep T tau y‖ ^ 2 = ‖y‖ ^ 2 := by
    rw [cnStep_eq_neg_shift T h, norm_neg, h1, h2]
    ring
  have := congrArg Real.sqrt hsq
  rwa [Real.sqrt_sq (norm_nonneg _), Real.sqrt_sq (norm_nonneg _)] at this
