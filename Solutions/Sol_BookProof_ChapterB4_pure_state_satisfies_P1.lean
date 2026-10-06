-- Generated from ChapterB4.lean — solution of BookProof.ChapterB4.pure_state_satisfies_P1
import Mathlib
import Definitions.Def_ChapterB4
import Theorems.Thm_BookProof_ChapterB4_P2_isPureState
open BookProof.ChapterB4




open Matrix

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution :
    ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P1) = 1 / 2 := by

  refine ⟨P2, P2_isPureState, ?_⟩
  simp [P1, P2, Matrix.trace_fin_two]
