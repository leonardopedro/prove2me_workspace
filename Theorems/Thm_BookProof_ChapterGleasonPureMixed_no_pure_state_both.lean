-- Generated from ChapterGleasonPureMixed.lean — theorem BookProof.ChapterGleasonPureMixed.no_pure_state_both
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.ChapterB4
open BookProof.BRSTNilpotent
open BookProof.ChapterGleasonPureMixed


open scoped BigOperators
open Matrix

theorem BookProof.ChapterGleasonPureMixed.no_pure_state_both :
    ¬ ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsPureState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2 := by sorry
