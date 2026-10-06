-- Generated from ChapterB4.lean — theorem BookProof.ChapterB4.no_pure_state_satisfies_both
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4



open Matrix

noncomputable section

theorem BookProof.ChapterB4.no_pure_state_satisfies_both :
    ¬ ∃ ρ, IsPureState ρ ∧ Matrix.trace (ρ * P1) = 1 / 2 ∧
      Matrix.trace (ρ * P2) = 1 / 2 := by sorry
