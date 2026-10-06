-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.partial_sum
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.partial_sum (c : ℕ → ℝ) (N : ℕ) :
    ∑ n ∈ Finset.range N, stickProb c n = 1 - stickTail c N := by sorry
