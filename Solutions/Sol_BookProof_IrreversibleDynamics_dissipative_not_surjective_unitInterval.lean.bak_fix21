-- Generated from ChapterIrreversibleDynamics.lean — solution of BookProof.IrreversibleDynamics.dissipative_not_surjective_unitInterval
import Mathlib
import Definitions.Def_ChapterIrreversibleDynamics
open BookProof.IrreversibleDynamics




open MeasureTheory Function Set
open scoped ENNReal

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ y ∈ Set.Icc (0 : ℝ) 1, y ∉ dissipative '' Set.Icc (0 : ℝ) 1 := by

  refine ⟨1, by norm_num, ?_⟩
  rintro ⟨x, hx, hxy⟩
  simp only [Set.mem_Icc, dissipative_apply] at hx hxy
  linarith [hx.2]
