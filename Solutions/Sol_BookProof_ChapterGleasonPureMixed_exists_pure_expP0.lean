-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.exists_pure_expP0
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_Q_isPure
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_E_Q_P0
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsPureState ρ ∧ E ρ P0 = 1/2 := ⟨Q, Q_isPure, E_Q_P0⟩
