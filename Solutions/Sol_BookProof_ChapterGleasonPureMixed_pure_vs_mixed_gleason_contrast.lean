-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.pure_vs_mixed_gleason_contrast
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_no_pure_state_both
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_exists_mixed_state_both
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution :
    (¬ ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsPureState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) ∧
    (∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) := ⟨no_pure_state_both, exists_mixed_state_both⟩
