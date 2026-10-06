-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stickTail_le_one
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stickTail_le_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1) (N : ℕ) :
    stickTail c N ≤ 1 := by sorry
