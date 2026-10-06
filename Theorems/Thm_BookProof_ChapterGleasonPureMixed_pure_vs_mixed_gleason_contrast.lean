-- Generated from ChapterGleasonPureMixed.lean — theorem BookProof.ChapterGleasonPureMixed.pure_vs_mixed_gleason_contrast
import Mathlib
import Definitions.Def_ChapterGleasonPureMixed
import Definitions.Def_ChapterB4
import Definitions.Def_ChapterBRSTNilpotent
open BookProof.ChapterB4
open BookProof.BRSTNilpotent
open BookProof.ChapterGleasonPureMixed


open scoped BigOperators
open Matrix

theorem BookProof.ChapterGleasonPureMixed.pure_vs_mixed_gleason_contrast :
    (¬ ∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsPureState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) ∧
    (∃ ρ : Matrix (Fin 2) (Fin 2) ℝ, IsMixedState ρ ∧ E ρ P0 = 1/2 ∧ E ρ Q = 1/2) := by sorry
