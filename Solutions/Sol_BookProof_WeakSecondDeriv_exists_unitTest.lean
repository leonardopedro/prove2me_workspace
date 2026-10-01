-- Generated from ChapterWeakSecondDerivative.lean — solution of BookProof.WeakSecondDeriv.exists_unitTest
import Mathlib
import Definitions.Def_ChapterWeakSecondDerivative
open BookProof.WeakSecondDeriv




open MeasureTheory Filter Topology intervalIntegral Set

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution : ∃ ρ : ℝ → ℝ, IsTestFun ρ ∧ ∫ x, ρ x = 1 := by

  let f : ContDiffBump (0 : ℝ) := ⟨1, 2, one_pos, one_lt_two⟩
  exact ⟨f.normed volume, ⟨f.contDiff_normed, f.hasCompactSupport_normed⟩, f.integral_normed⟩
