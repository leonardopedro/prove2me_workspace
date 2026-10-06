-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_image_Icc
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution (a b : ℝ) :
    dissipative '' Set.Icc a b = Set.Icc (a / 2) (b / 2) := by

  ext y
  simp only [dissipative_apply, Set.mem_image, Set.mem_Icc]
  constructor
  · rintro ⟨x, ⟨h1, h2⟩, rfl⟩; exact ⟨by linarith, by linarith⟩
  · rintro ⟨h1, h2⟩; exact ⟨2 * y, ⟨by linarith, by linarith⟩, by ring⟩
