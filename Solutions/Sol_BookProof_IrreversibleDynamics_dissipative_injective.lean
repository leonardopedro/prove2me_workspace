-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_injective
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal


@[simp] private theorem dissipative_apply (x : ℝ) : dissipative x = x / 2 := rfl

set_option maxHeartbeats 1000000 in
theorem solution : Function.Injective dissipative := by

  intro a b h
  simp only [dissipative_apply] at h
  linarith
