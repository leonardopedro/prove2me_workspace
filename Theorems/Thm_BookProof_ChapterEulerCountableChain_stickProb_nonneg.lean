-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stickProb_nonneg
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stickProb_nonneg (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (n : ℕ) :
    0 ≤ stickProb c n := by sorry
