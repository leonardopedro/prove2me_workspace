-- Generated from ChapterWeakSecondDerivative.lean — solution of BookProof.WeakSecondDeriv.exists_supp
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
import Theorems.Thm_BookProof_WeakSecondDeriv_IsTestFun_hasCompactSupport
open BookProof.WeakSecondDeriv




open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {g : ℝ → ℝ} (h : IsTestFun g) :
    ∃ R : ℝ, 0 ≤ R ∧ tsupport g ⊆ Icc (-R) R := by

  obtain ⟨R, hR⟩ := (h.hasCompactSupport.isCompact.isBounded).subset_closedBall (0 : ℝ)
  refine ⟨|R|, abs_nonneg R, fun x hx => ?_⟩
  have hx' := hR hx
  rw [Real.closedBall_eq_Icc] at hx'
  simp only [zero_sub, zero_add, mem_Icc] at hx' ⊢
  exact ⟨by linarith [le_abs_self R, hx'.1], by linarith [le_abs_self R, hx'.2]⟩
