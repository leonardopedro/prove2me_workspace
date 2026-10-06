-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.exists_mixed_state_both
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_halfI_isMixed
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2 := by

  refine ⟨(1/2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ), halfI_isMixed, ?_, ?_⟩
  · simp [E, P0, Matrix.trace, Fin.sum_univ_two]
  · simp [E, Q, Matrix.trace, Fin.sum_univ_two]; norm_num
