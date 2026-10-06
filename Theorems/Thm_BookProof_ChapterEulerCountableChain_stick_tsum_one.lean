-- Generated from ChapterEulerCountableChain.lean — theorem BookProof.ChapterEulerCountableChain.stick_tsum_one
import Mathlib
import Definitions.Def_ChapterEulerCountableChain
open BookProof.ChapterEulerCountableChain


open scoped BigOperators
open Filter Topology

theorem BookProof.ChapterEulerCountableChain.stick_tsum_one (c : ℕ → ℝ) (hc : ∀ n, 0 ≤ c n ∧ c n ≤ 1)
    (htail : Tendsto (stickTail c) atTop (𝓝 0)) :
    ∑' n, stickProb c n = 1 := by sorry
