-- Generated from ChapterB4.lean — theorem BookProof.ChapterB4.pure_state_satisfies_P2
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4



open Matrix

noncomputable section

theorem BookProof.ChapterB4.pure_state_satisfies_P2 :
    ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P2) = 1 / 2 := by sorry
