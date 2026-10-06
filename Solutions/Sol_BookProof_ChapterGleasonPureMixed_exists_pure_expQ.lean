-- Generated from ChapterGleasonPureMixed.lean — solution of BookProof.ChapterGleasonPureMixed.exists_pure_expQ
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_P0_isPure
import Theorems.Thm_BookProof_ChapterGleasonPureMixed_E_P0_Q
open BookProof.ChapterGleasonPureMixed



open scoped BigOperators
open Matrix

set_option maxHeartbeats 1000000 in
theorem solution : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsPureState ρ ∧ E ρ Q = 1/2 := ⟨P0, P0_isPure, E_P0_Q⟩
