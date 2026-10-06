-- Generated from ChapterB4.lean — theorem BookProof.ChapterB4.mixed_state_satisfies_both
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4



open Matrix

noncomputable section

theorem BookProof.ChapterB4.mixed_state_satisfies_both :
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P1) = 1 / 2 ∧
    Matrix.trace (((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) * P2) = 1 / 2 := by sorry
