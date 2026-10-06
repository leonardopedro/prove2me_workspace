-- Generated from ChapterE4.lean — theorem BookProof.ChapterE4.wave_prob_sum
import Mathlib
import Definitions.Def_ChapterE4
open BookProof.ChapterE4


open scoped BigOperators

theorem BookProof.ChapterE4.wave_prob_sum (θ : ℕ → ℝ) (s d : ℕ) :
    ∑ i ∈ Finset.Icc s (s + d), (wave θ s d i) ^ 2 = 1 := by sorry
