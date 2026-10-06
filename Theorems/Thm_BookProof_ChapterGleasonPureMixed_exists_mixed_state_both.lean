-- Generated from ChapterGleasonPureMixed.lean — theorem BookProof.ChapterGleasonPureMixed.exists_mixed_state_both
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.BRSTNilpotent
open BookProof.ChapterGleasonPureMixed


open scoped BigOperators
open Matrix

theorem BookProof.ChapterGleasonPureMixed.exists_mixed_state_both : ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ,
    IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2 := by sorry
