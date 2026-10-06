-- Generated from ChapterB4.lean — theorem BookProof.ChapterB4.mixed_state_not_pure
import Mathlib
import Definitions.Def_ChapterB4
open BookProof.ChapterB4



open Matrix

noncomputable section

theorem BookProof.ChapterB4.mixed_state_not_pure :
    ¬ IsPureState ((1 / 2 : ℝ) • (1 : Matrix (Fin 2) (Fin 2) ℝ)) := by sorry
